# 02. Lusyでの基本ルール

[← README](../README.md)

---

Lusyの開発では、原則として以下の流れを使用します。

```text
main
 ↓
Branch作成
 ↓
開発
 ↓
Commit
 ↓
Push
 ↓
Pull Request
 ↓
Review
 ↓
Merge
```

---

## Rule 1: mainで直接開発しない

NG:

```bash
git switch main
# ここで大量にコードを書く
```

作業するときは必ずBranchを作ります。

```bash
git switch main
git pull
git switch -c feature/example
```

---

## Rule 2: mainへ直接Pushしない

原則として、

```text
作業Branch → Pull Request → Review → main
```

という流れで変更します。

実務のRepositoryでは、多くの場合 **Branch Protection** が設定されており、
`main` への直接Pushを試すとGitHubが以下のように拒否します。

```text
! [remote rejected] main -> main (protected branch hook declined)
```

> ⚠️ **このTraining Repositoryでは、Branch Protectionが有効になっていません。**
> Private RepositoryかつGitHub Freeプランのため、現時点では設定できないためです。
> つまり `main` へ直接Pushすると **成功してしまいます。**
>
> **絶対に試さないでください。** ここはGitHubが守ってくれない状態です。
> 誤ってPushしてしまった場合は、自分で `reset` や `revert` を試す前に管理者へ報告してください。
>
> 管理者向けの有効化手順は [admin-setup.md](admin-setup.md) にあります。

---

## Rule 3: 1つのBranchでは1つの目的を扱う

良い例:

```text
feature/login
fix/login-validation
docs/setup-guide
```

悪い例:

```text
feature/everything
```

ログイン機能、DB変更、UI変更、README修正などを全部1つに混ぜないようにします。

---

## Rule 4: Commitは意味のある単位に分ける

悪い例:

```text
いろいろ変更
```

良い例:

```text
Add login API
Add email validation
Fix login error handling
```

---

## Rule 5: Commit前にdiffを見る

最低でも、

```bash
git status
git diff
```

を確認してからCommitしてください。意図していないファイルが混ざっていないか確認します。

---

## Rule 6: 機密情報をCommitしない

以下はGitHubへPushしてはいけません。

- Password
- API Key
- Access Token
- Private Key
- `.env`
- AWS Credential
- Database Password
- 個人情報
- その他のSecret

例:

```text
.env
.env.local
credentials.json
private.key
```

などは `.gitignore` に追加します。

**一度GitへCommitしたSecretは、ファイルを削除しただけではGit履歴に残ります。**
「消したから大丈夫」ではありません。漏らしてしまった場合は、まずそのKey/Tokenを **無効化（rotate）** してください。

> このRepositoryのCIは、`members/` と `conflict-training/` にSecretらしき文字列や
> `.env` などの禁止ファイルが含まれていないかを自動でチェックします。
> Pull Requestで赤いバツが出たら、CIのログを読んで直してからもう一度Pushしてください。
> **CIが落ちたPull Requestはマージしません。** これは実務と同じルールです。

---

次: [03 Setup](03-setup.md)
