# 01. GitとGitHub / 最低限理解する用語

[← README](../README.md)

---

## GitとGitHubの違い

### Git

Gitは **バージョン管理システム** です。自分のPC上で、

- ファイルの変更履歴
- Commit
- Branch
- Merge

などを管理します。**インターネットに繋がっていなくても動きます。**

### GitHub

GitHubは、Git Repositoryをインターネット上で共有し、チーム開発するためのサービスです。

- Repository共有
- Pull Request
- Code Review
- Issue
- GitHub Actions
- Branch Protection

Pull RequestやReviewは **Gitの機能ではなくGitHubの機能** です。ここは混同しやすいので注意してください。

---

## 最低限理解する用語

### Repository

プロジェクト全体と、その変更履歴を管理する場所です。略して **Repo** とも呼びます。

### Local Repository

自分のPCにあるRepositoryです。

### Remote Repository

GitHubなどのサーバー上にあるRepositoryです。通常、GitHub上のRemote Repositoryには

```text
origin
```

という名前が付いています。

### Working Tree

現在自分が編集しているファイル群です。

### Staging Area

次のCommitに含める変更を一時的に置く場所です。`git add` すると変更がStaging Areaに入ります。

### Commit

ある時点の変更を、Gitの履歴として保存することです。`git commit` で作成します。

### Branch

開発作業を分岐させる仕組みです。

```text
main
│
├── feature/login
│
└── fix/login-error
```

のように、機能ごとに別のBranchで作業できます。

### main

通常、プロジェクトの基準となるBranchです。Lusyでは原則として、

> **main上で直接開発しません。**

### HEAD

現在自分がいるCommit / Branchを指します。

### Push

Local RepositoryのCommitをGitHubへ送ることです。

### Pull

GitHubの最新変更を取得し、現在のBranchへ反映することです。

### Pull Request

自分のBranchの変更を、

> 「この変更をmainへ入れてください」

と提案するGitHubの機能です。略して **PR** と呼びます。

### Review

Pull Requestに対して、他メンバーが変更内容を確認することです。

### Merge

複数のBranchの変更を統合することです。

### Conflict

Gitが、

> 「どちらの変更を採用すればよいか判断できない」

状態です。人間が正しい内容を判断して修正します。
**Conflictは異常ではありません。** 複数人で同じコードを編集していれば発生します。

---

## Gitの基本的な流れ

```text
ファイルを変更する
        ↓
git add
        ↓
Staging Area
        ↓
git commit
        ↓
Local Repository
        ↓
git push
        ↓
GitHub
```

つまり、

```bash
git add .
git commit -m "Add example"
git push
```

の3つは、それぞれ **別の場所へ変更を移す** 操作であり、意味がまったく違います。

---

## チーム開発の全体フロー

```text
mainを最新にする
        ↓
作業Branchを作る
        ↓
実装する
        ↓
変更内容を確認する
        ↓
Commitする
        ↓
Pushする
        ↓
Pull Requestを作る
        ↓
Reviewを受ける
        ↓
必要なら修正する
        ↓
Mergeする
```

---

次: [02 Rules](02-rules.md)
