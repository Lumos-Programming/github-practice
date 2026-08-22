# 実習1: CloneからPull Requestまで

[← 実習一覧](README.md)

**目的:** Gitの一連の流れ（clone → branch → 編集 → add → commit → push → PR）を1周する
**目安:** 40分

先に [事前準備](../docs/03-setup.md) を済ませておいてください。

以下、`<your-name>` は自分の名前（英小文字・ハイフン可、例 `taro`）に読み替えます。

---

## Step 1: RepositoryをClone

```bash
git clone https://github.com/Lumos-Programming/github-practice.git
cd github-practice
```

> すでにCloneしている人はこのStepを飛ばしてください。

---

## Step 2: 現在の状態を確認

```bash
git status
git branch
```

`* main` と表示されることを確認します。

---

## Step 3: mainを最新化

```bash
git switch main
git pull
```

**作業を始める前に必ずこれをやる**、と覚えてください。

---

## Step 4: 自分のBranchを作る

```bash
git switch -c training/<your-name>
```

例:

```bash
git switch -c training/taro
```

確認:

```bash
git branch
```

`* training/taro` になっていればOKです。

---

## Step 5: 自分のファイルを作る

`members/` の中に `members/<your-name>.md` を作成してください。

> **ファイル名は半角小文字・数字・ハイフンのみ**です（CIがチェックします）。
> 例: `taro.md`, `taro-yamada.md`

内容の雛形は [members/\_template.md](../members/_template.md) にあります。コピーして書き換えてください。

```markdown
# Taro

## Role

Lusy / 開発メンバー

## Git Training

Git/GitHub研修を開始しました。

## Learning

- Git
- GitHub
- Pull Request
```

---

## Step 6: 変更を確認

```bash
git status
```

`Untracked files` に自分のファイルが出ていることを確認します。

```bash
git diff
```

> **何も表示されません。** 新規ファイルはまだGitに追跡されていないため、`git diff` の対象外だからです。
> これは正常です。ここで「あれ？」と思えたら、Gitの仕組みを理解し始めています。

---

## Step 7: Staging

```bash
git add members/<your-name>.md
```

確認:

```bash
git status
```

`Changes to be committed` に移動していればOKです。

---

## Step 8: Staging済みの変更を確認

```bash
git diff --staged
```

今度は中身が表示されます。**Commit前にこれを見る習慣をつけてください。**

---

## Step 9: Commit

```bash
git commit -m "Add <your-name> training profile"
```

例:

```bash
git commit -m "Add Taro training profile"
```

---

## Step 10: Commit履歴を確認

```bash
git log --oneline
```

自分のCommitが一番上にあることを確認します。

---

## Step 11: Push

```bash
git push -u origin training/<your-name>
```

例:

```bash
git push -u origin training/taro
```

---

## Step 11.5: （任意）mainへ直接Pushを試してみる

ルールが「お願い」ではなく「仕組み」で守られていることを体験しておきます。

```bash
git switch main
git commit --allow-empty -m "Test protected branch"
git push
```

次のように拒否されれば成功です。

```text
! [remote rejected] main -> main (protected branch hook declined)
```

**必ず後片付けをしてください。**

```bash
git reset --hard origin/main
git switch training/<your-name>
```

---

## Step 12: GitHubでPull Requestを作成

1. GitHubでこのRepositoryを開く
2. 黄色いバナーの **Compare & pull request** をクリック
   （出ていなければ **Pull requests** → **New pull request**）
3. base が `main`、compare が `training/<your-name>` になっていることを確認

```text
base: main  ←  compare: training/<your-name>
```

### Title

```text
Add Taro training profile
```

### 本文

Pull Requestを開くとテンプレートが自動で入ります。**消さずに埋めてください。**

```markdown
## What

Git/GitHub Training用のプロフィールファイルを追加しました。

## Why

Git/GitHub研修の実習1のため。

## Changes

- members/taro.md を追加

## How to Test

members/taro.md が追加されていることを確認してください。

## Check

- [x] 自分で動作確認した
- [x] 不要な変更が入っていない
- [x] SecretをCommitしていない
```

最後に自分のIssue番号を `Refs #12` の形で書いておくと、Issueとつながって追いやすくなります。

4. **Create pull request** をクリック

---

## Step 13: CIの結果を確認

Pull Requestの下部に **Training Check** が表示されます。

- ✅ 緑 → OK。実習2へ進んでください
- ❌ 赤 → **Details** をクリックしてログを読み、原因を直して再Pushしてください

CIが落ちる主な原因:

- `members/` のファイル名に大文字・スペース・日本語が入っている
- `.env` や `.DS_Store` を巻き込んでいる
- Secretらしき文字列を書いてしまった

修正はいつも同じ手順です。

```bash
# 直す
git status
git diff
git add .
git commit -m "Fix file name"
git push
```

**新しいPull Requestを作り直す必要はありません。**

---

## 完了

自分のIssueで、実習1のチェックを付けてください。
まだMergeはしません。実習2でお互いのPull RequestをReviewしてからMergeします。

次: [実習2: Pull Request Review](02-review.md)
