# Lusy Git / GitHub Training

Lusy（Lumos System Team）向けの **Git / GitHub 練習用リポジトリ**です。

読むだけの研修ではありません。このリポジトリで実際にBranchを作り、ファイルを編集し、
Commit・Push・Pull Request・Review・Merge・Conflict解消までを **手を動かして** 行います。

Gitコマンドを暗記することではなく、

> **チーム開発でGit/GitHubを安全に使えるようになること**

を目的とします。

---

## 研修の進め方

1. 管理者があなた専用の **Issue** を1件作成します。**そのIssueがあなたの進行表**です。
2. Issueのチェックリストを上から順に進めます。
3. **各Stepの見出しの下にある 👉 のリンクが、その実習の手順書（`exercises/` 配下）です。**
   チェックリストだけでは進められません。必ずリンクを開いてから進めてください。
4. 用語やコマンドで詰まったら `docs/` を引きます。
5. すべてのチェックが付いたら、Issueを **Close** して研修完了です。

> このリポジトリでは **意図的に失敗して構いません。**
> Branchを間違える・Commitを間違える・Conflictを起こす・Commitを取り消す。
> 壊し方と直し方の両方を、実際の開発Repositoryに入る前に経験してください。

`main` への直接Pushは禁止です。必ずPull Request経由で変更してください。

> ⚠️ **このリポジトリは現在、技術的には `main` への直接Pushができてしまいます。**
> Branch Protectionを設定したいのですが、Private RepositoryかつGitHub Freeプランのため
> 現時点では有効化できません（[docs/admin-setup.md](docs/admin-setup.md) に詳細）。
> **GitHubが止めてくれないので、ルールとして各自が守ってください。**
> 誤ってPushしてしまった場合は、隠さずに管理者へ報告してください。

---

## 実習（ここが本体）

| # | 実習 | 学ぶこと |
|---|---|---|
| 1 | [CloneからPull Requestまで](exercises/01-clone-to-pr.md) | clone / switch -c / add / commit / push / PR |
| 2 | [Pull Request Review](exercises/02-review.md) | Review / Comment / 指摘対応の追加Push |
| 3 | [PullとFetch](exercises/03-pull-fetch.md) | fetchとpullの違い / log --graph |
| 4 | [変更を取り消す](exercises/04-restore.md) | restore / restore --staged |
| 5 | [Stash](exercises/05-stash.md) | 作業途中の一時退避 |
| 6 | [Conflictを解消する](exercises/06-conflict.md) | Conflictの発生と解消 |
| 7 | [Commitを取り消す](exercises/07-undo-commit.md) | revert / reset --soft / reset --hard |

実習の一覧と所要時間は [exercises/README.md](exercises/README.md) にあります。

---

## ドキュメント（困ったときに引く）

| ページ | 内容 |
|---|---|
| [01 Concepts](docs/01-concepts.md) | GitとGitHubの違い / 最低限理解する用語 |
| [02 Rules](docs/02-rules.md) | Lusyでの基本ルール（6つ） |
| [03 Setup](docs/03-setup.md) | 事前準備（初回のみ） |
| [04 Commands](docs/04-commands.md) | Gitコマンド解説 |
| [05 Conventions](docs/05-conventions.md) | Commit / Branch / PR / Review の書き方 |
| [06 Troubleshooting](docs/06-troubleshooting.md) | 困ったときの確認順序 / 危険な操作 |
| [99 Cheatsheet](docs/99-cheatsheet.md) | コマンド早見表 |

---

## 最初にやること

まだGitの初期設定をしていない人は、先に [事前準備](docs/03-setup.md) を済ませてください。

```bash
git --version
git config --global user.name
git config --global user.email
```

3つとも値が表示されればOKです。準備ができたら [実習1](exercises/01-clone-to-pr.md) へ進みます。

---

## 困ったら

Gitで分からなくなったら、**むやみにコマンドを実行しないでください。** まずこれです。

```bash
git status
```

詳しい確認手順は [06 Troubleshooting](docs/06-troubleshooting.md) にあります。
それでも解決しない場合は、自分のIssueに `git status` の出力を貼って質問してください。

---

## 構成

```text
.
├── README.md                この入口
├── docs/                    リファレンス（引くための資料）
├── exercises/               実習1〜7の手順
├── members/                 各自のプロフィールファイルを置く場所
├── conflict-training/       Conflict実習用のファイル
├── scripts/                 管理者用スクリプト
└── .github/                 Issue / PR テンプレート、CI
```

---

## 管理者向け

リポジトリの初期設定（Branch Protection、CODEOWNERS、Conflict用Seed Branch、メンバー分のIssue作成）は
[docs/admin-setup.md](docs/admin-setup.md) を参照してください。

---

## References

本研修は以下の公式ドキュメントを基準としています。
不明なGitコマンドは、ブログ等ではなくまず公式Referenceを確認してください。

- [Git Reference](https://git-scm.com/docs)
- [GitHub Docs — Pull requests](https://docs.github.com/pull-requests)
- [GitHub Docs — Reviewing changes in pull requests](https://docs.github.com/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests)
- [GitHub Docs — Protected branches](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
