# 管理者向け: リポジトリのセットアップと研修の回し方

[← README](../README.md)

研修者はこのページを読む必要はありません。

---

## 全体像

このRepositoryは「読ませる」のではなく「GitHubの仕組みで学ばせる」構成です。

| 仕組み | 教えていること |
|---|---|
| Branch Protection | Rule 1・2（mainで直接開発しない / 直接Pushしない）を**物理的に強制** |
| Pull Request Template | PRの書き方を、読ませるのではなく**枠として与える** |
| CODEOWNERS | Reviewerの自動アサイン |
| GitHub Actions | Secret混入・命名規約違反を**赤いバツ**で気づかせる |
| Issue（1人1件） | 進捗の可視化。研修者ごとのチェックリスト |
| `seed/conflict` Branch | 相方を待たずに、1人で確実にConflictを起こせる仕込み |

---

## セットアップ手順

### 0. 教材をPushする（初回のみ）

Branch Protectionを設定する**前に**、この教材一式を `main` に入れてください。

```bash
cd github-practice
git add .
git commit -m "Add Git/GitHub training materials"
git push -u origin main
```

### 1. Labelを作る

Issue Templateが `training` / `question` Labelを使います。**存在しないと付与されません。**

```bash
gh label create training --color 0E8A16 --description "Git/GitHub研修の進行表"
gh label create question --color D876E3 --description "研修中の質問" --force
```

### 2. CODEOWNERS を編集する

[`.github/CODEOWNERS`](../.github/CODEOWNERS) の `<REVIEWER>` を、実在するTeamまたは個人アカウントに置き換えてください。
存在しない指定は警告になり、自動アサインが機能しません。

```text
/docs/    @Lumos-Programming/core
```

個人アカウントを使う場合:

```text
/docs/    @your-github-account
```

### 3. Actions を有効にする

Settings → Actions → General → 「Allow all actions and reusable workflows」

Pull Requestを1件作って、**Training Check** が走ることを確認してください。

### 4. Branch Protection を設定する

Settings → Branches → Add branch protection rule

| 項目 | 設定 |
|---|---|
| Branch name pattern | `main` |
| Require a pull request before merging | ✅ |
| └ Require approvals | ✅ **1** |
| └ Dismiss stale pull request approvals when new commits are pushed | ✅（推奨） |
| └ Require review from Code Owners | ✅（CODEOWNERS設定後） |
| Require status checks to pass before merging | ✅ |
| └ Status checks | `研修ルールのチェック` を検索して追加 |
| Require branches to be up to date before merging | ✅（Conflict体験が増えるので推奨） |
| Do not allow bypassing the above settings | ✅ |

> **Status checkは、一度CIが走った後でないと検索候補に出ません。**
> 先にPull Requestを1件作ってCIを走らせてから設定してください。

CLIで設定する場合:

```bash
gh api -X PUT repos/Lumos-Programming/github-practice/branches/main/protection \
  -H "Accept: application/vnd.github+json" \
  --input - <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["研修ルールのチェック"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true
  },
  "restrictions": null
}
JSON
```

> ⚠️ **Private Repositoryの場合、プランによってBranch Protection / Rulesets が使えないことがあります。**
> 設定画面に項目が出ない場合は、Repositoryの可視性かOrganizationのプランを確認してください。
> どうしても使えない場合、Rule 1・2は「文書上のルール」として運用し、
> 実習1のStep 11.5（直接Pushが拒否されることの確認）はスキップしてください。

### 5. Conflict実習用の Seed Branch を作る

```bash
./scripts/create-conflict-seed.sh
```

`seed/conflict` が作られ、`conflict-training/solo.md` の1行だけが `main` と異なる状態になります。
これにより、研修者は相方を待たずに1人でConflictを再現できます。

確認:

```bash
git fetch
git diff main origin/seed/conflict
```

`Message: Hello` → `Message: Hello from Seed` の1行だけ差分があればOKです。

> **`seed/conflict` はBranch Protectionの対象に含めないでください。**
> 作り直すときにforce pushが必要になります。

### 6. 研修者を招待する

Settings → Collaborators and teams から、**Write権限**で招待します。

> Read権限だとBranchをPushできません。Write権限が必要です。

---

## メンバー分のIssueを作る

研修者ひとりにつき1件、Issueを作成します。

1. Issues → **New issue**
2. **Git/GitHub 研修 進行表** を選択
3. 入力する項目:

| 項目 | 入力例 | 備考 |
|---|---|---|
| タイトル | `Git/GitHub 研修: 山田太郎` | `<名前>` を置き換える |
| 研修者 | `@taro-yamada` | GitHubアカウント |
| ファイル名に使う名前 | `taro` | `members/taro.md` になる |
| Conflict実習のペア番号 | `01` | Part Bを行う場合のみ。ペアの2人に同じ番号を割り当てる |
| 進行表 | そのまま | 編集不要 |

4. 右側の **Assignees** で、その研修者本人をアサインする（**重要**）
5. Create

> ペア番号は `conflict-training/pair-01.md` 〜 `pair-05.md` に対応しています。
> 6組以上いる場合は、`pair-06.md` などを同じ形式で追加してください。

### CLIでまとめて作る場合

```bash
gh issue create \
  --title "Git/GitHub 研修: 山田太郎" \
  --label training \
  --assignee taro-yamada \
  --body-file - <<'MD'
研修者: @taro-yamada
ファイル名: taro

進行表は .github/ISSUE_TEMPLATE/training.yml の内容を貼り付けてください。
MD
```

> CLIだとテンプレートのチェックリストが自動で入りません。
> **人数が少ないうちはWeb UIから作るほうが確実です。**

---

## 進捗を見る

### Projectsで一覧にする（推奨）

1. Projects → New project → **Board**
2. `training` Labelの付いたIssueを追加
3. カラムを `未着手` / `実習1-3` / `実習4-7` / `完了` にする

各Issueのチェックボックスの進捗（`12/48` のような表示）がIssue一覧にも出るため、
誰がどこで止まっているかがひと目で分かります。

### 止まっている人を見つける

```bash
gh issue list --label training --state open
gh pr list --state open
```

---

## 研修中に管理者がやること

| タイミング | やること |
|---|---|
| 実習1の後 | 各自のPull Requestが揃うのを待つ。CIが落ちている人に声をかける |
| 実習2 | 誰が誰をReviewするか割り当てる（重複や漏れを防ぐ） |
| 実習2の後 | Pull Requestが `main` にMergeされたことを確認 → 実習3に進んでよいと伝える |
| 実習6 | `conflict-training/solo.md` を変更するPRが来たら **Mergeしない**（実習の仕込みが壊れます） |
| 完了後 | Issueの「振り返り」を読み、次回の教材改善に反映する |

---

## 次の期のためにリセットする

```bash
# 1. 前回の研修Branchを一掃する
git fetch --prune
git branch -r | grep 'origin/training/' | sed 's|origin/||' | \
  xargs -I{} git push origin --delete {}

# 2. members/ を空にする（残しておいても構いません）
git switch -c chore/reset-training
git rm members/*.md
git checkout main -- members/README.md members/_template.md
git commit -m "Reset members for next training"
git push -u origin chore/reset-training
# → Pull Requestを作ってMerge

# 3. solo.md が元に戻っているか確認する
git switch main && git pull
grep -n "Message:" conflict-training/solo.md   # → "Message: Hello" であること

# 4. Seed Branchを作り直す（必要なら）
./scripts/create-conflict-seed.sh
```

前回のIssueはCloseされているので、そのまま記録として残しておけます。

---

## 教材を直すとき

教材（`docs/` / `exercises/` / `.github/`）自身の変更も、**Pull Request経由で行ってください。**
管理者が直接Pushしていると、研修者に示しがつきません。

```bash
git switch main && git pull
git switch -c docs/improve-conflict-exercise
# 編集
git add . && git commit -m "Improve conflict exercise wording"
git push -u origin docs/improve-conflict-exercise
```
