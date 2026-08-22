# 05. Commit / Branch / Pull Request / Review の書き方

[← README](../README.md)

---

## Commit Messageの書き方

Commit Messageは、

> **何を変更したか**

が分かるようにしてください。半年後の自分と、他のメンバーが読みます。

### 悪い例

```text
fix
update
修正
いろいろ変更
aaaa
```

### 良い例

```text
Add login API
Fix login validation
Update README setup guide
Remove unused authentication code
```

### 基本形

```text
<動詞> <変更内容>
```

よく使う動詞:

```text
Add       追加した
Fix       バグを直した
Update    既存のものを更新した
Remove    削除した
Refactor  振る舞いを変えずに構造を整理した
Rename    名前を変えた
Improve   改善した
```

---

## Branch名の付け方

Branch名を見ただけで、何の作業か分かるようにします。

| 用途 | 形式 | 例 |
|---|---|---|
| 新機能 | `feature/<name>` | `feature/login`, `feature/discord-auth` |
| Bug Fix | `fix/<name>` | `fix/login-validation`, `fix/database-timeout` |
| Documentation | `docs/<name>` | `docs/setup-guide` |
| Refactoring | `refactor/<name>` | `refactor/auth-service` |
| 本研修 | `training/<your-name>` | `training/taro` |

小文字とハイフンを使い、日本語やスペースは使いません。

---

## Pull Requestの書き方

Pull Requestは、

> 「何を変更したのか」

だけでなく、

> **「なぜ変更したのか」**

がReviewerに分かるようにしてください。Reviewerはあなたの頭の中を知りません。

### 基本形

このRepositoryでは Pull Request を開くと、以下のテンプレートが自動で入ります。

```markdown
## What
何を変更したか。

## Why
なぜ変更したか。

## Changes
- 変更1
- 変更2

## How to Test
確認方法。

## Check
- [ ] 自分で動作確認した
- [ ] 不要な変更が入っていない
- [ ] SecretをCommitしていない
```

### Issueと紐づける

PR本文に次のように書くと、**そのPRがMergeされたときにIssueが自動でCloseされます。**

```text
Closes #12
```

実務で頻繁に使います。研修のIssueは最後まで使うので、
実習中のPRでは `Closes` ではなく `Refs #12` と書いてください（自動Closeされません）。

### Pull Requestは小さくする

1つのPull Requestに大量の変更が入ると、

- Reviewが難しい
- Bugを見つけにくい
- Conflictしやすい
- Revertしにくい
- 変更理由が分かりにくい

という問題があります。**Small PR** を心がけてください。

---

## Reviewのやり方

Reviewは、

> 「間違いを探して相手を評価する作業」

ではありません。チームとして

- Bugを防ぐ
- 設計を改善する
- 知識を共有する
- コード品質を上げる

ために行います。

### Reviewの3種類

GitHubの「Files changed」→「Review changes」から選びます。

| 種類 | 意味 |
|---|---|
| **Comment** | コメントのみ。可否の判断はしない |
| **Approve** | 問題なし。Mergeしてよい |
| **Request changes** | 修正が必要。直るまでMergeしない |

### 確認すること

1. **PRの目的と変更が一致しているか**
   `Fix login bug` というPRなのに大規模なDB変更まで含まれていないか。
2. **意図しないファイルが入っていないか**
   `.env` / `node_modules/` / `.DS_Store` / `credentials.json` など。
3. **Secretが入っていないか**
   `API_KEY=` / `PASSWORD=` / `TOKEN=` / `SECRET=` / `PRIVATE_KEY=`。
4. **コードが理解できるか**
   必要以上に複雑になっていないか。
5. **Error Handlingがあるか**
   異常系を考慮しているか。
6. **既存機能を壊していないか**
   変更箇所以外への影響。

### Reviewコメントの書き方

攻撃的な表現ではなく、**変更理由が伝わる**コメントを書きます。

良い例:

```text
この処理はnullになる可能性があるので、チェックを追加した方が安全だと思います。
```

```text
この関数を分割すると責務が明確になりそうですが、どうでしょうか？
```

悪い例:

```text
ここ間違ってます
```

```text
なんでこう書いたんですか？
```

**「人」ではなく「コード」について書く**のが原則です。
「あなたのミス」ではなく「この行はこうすると安全」と書きます。

### 指摘を受けた側

同じBranchで修正して、同じBranchへPushするだけです。

```bash
git status
# 修正する
git diff
git add .
git commit -m "Update training profile"
git push
```

**Pull Requestを作り直す必要はありません。** 自動で変更が追加されます。
対応が終わったら、指摘コメントに返信して知らせます。

---

次: [06 Troubleshooting](06-troubleshooting.md)
