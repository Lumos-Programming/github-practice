# 04. Gitコマンド解説

[← README](../README.md) / 短くまとまった一覧は [99 Cheatsheet](99-cheatsheet.md)

---

## 目次

- [Repositoryを取得する — clone](#repositoryを取得する--clone)
- [現在の状態を確認する — status](#現在の状態を確認する--status)
- [Branch一覧を見る — branch](#branch一覧を見る--branch)
- [Branchを作成する — switch -c](#branchを作成する--switch--c)
- [Branchを移動する — switch](#branchを移動する--switch)
- [Branchを削除する — branch -d](#branchを削除する--branch--d)
- [変更を見る — diff](#変更を見る--diff)
- [Commit対象に追加する — add](#commit対象に追加する--add)
- [Commitする — commit](#commitする--commit)
- [GitHubへPushする — push](#githubへpushする--push)
- [最新状態を取得する — pull](#最新状態を取得する--pull)
- [情報だけ取得する — fetch](#情報だけ取得する--fetch)
- [Remoteを確認する — remote -v](#remoteを確認する--remote--v)
- [履歴を見る — log](#履歴を見る--log)
- [変更を取り消す — restore](#変更を取り消す--restore)
- [一時退避する — stash](#一時退避する--stash)
- [統合する — merge](#統合する--merge)
- [Commitを打ち消す — revert](#commitを打ち消す--revert)
- [Commitを戻す — reset](#commitを戻す--reset)
- [GitHub CLI — gh](#github-cli--gh)

---

## Repositoryを取得する — clone

```bash
git clone <URL>
```

GitHub上のRepositoryをLocal PCへコピーします。

```bash
git clone https://github.com/Lumos-Programming/github-practice.git
cd github-practice
```

---

## 現在の状態を確認する — status

```bash
git status
```

**最も重要なコマンドです。** 確認できるもの:

- 現在のBranch
- 変更したファイル
- 新規ファイル
- 削除したファイル
- `git add` 済みのファイル
- Conflictしているファイル

> **困ったら最初に `git status`。**
> Gitで何か分からなくなったら、他のコマンドを打つ前に必ず現在の状態を確認してください。

---

## Branch一覧を見る — branch

```bash
git branch
```

現在いるBranchには `*` が付きます。

```text
* feature/login
  main
```

Remote Branchも含める場合:

```bash
git branch -a
```

---

## Branchを作成する — switch -c

```bash
git switch -c <branch-name>
```

例:

```bash
git switch -c feature/login
```

これは「Branchを作成する」と「そのBranchへ移動する」を同時に行います。

**作成元は「今いるBranch」です。** `main` から分岐したいなら、先に `main` を最新にしてください。

```bash
git switch main
git pull
git switch -c feature/login
```

---

## Branchを移動する — switch

```bash
git switch <branch-name>
```

例:

```bash
git switch main
```

---

## Branchを削除する — branch -d

通常:

```bash
git branch -d <branch-name>
```

強制削除:

```bash
git branch -D <branch-name>
```

`-D` は **未Mergeの変更があるBranchも削除できる** ため注意してください。
基本的には `-d` を使い、拒否されたら「なぜ未Mergeなのか」を確認します。

---

## 変更を見る — diff

まだ `git add` していない変更:

```bash
git diff
```

`git add` 済み（次のCommitに入る）変更:

```bash
git diff --staged
```

重要なCommitの前は3点セットで確認します。

```bash
git status
git diff
git diff --staged
```

---

## Commit対象に追加する — add

特定ファイル:

```bash
git add README.md
```

複数:

```bash
git add file1.md file2.md
```

現在のDirectory以下をまとめて:

```bash
git add .
```

> `git add .` は楽ですが、**意図しないファイルを巻き込みやすい**コマンドです。
> 実行前に必ず `git status` を見てください。

---

## Commitする — commit

```bash
git commit -m "<message>"
```

例:

```bash
git commit -m "Add login API"
```

Merge中のCommitなど、メッセージが自動生成される場面では:

```bash
git commit --no-edit
```

とするとエディタを開かずにそのまま確定できます。

メッセージの書き方は [05 Conventions](05-conventions.md) を参照。

---

## GitHubへPushする — push

新しいBranchを初めてPushする場合:

```bash
git push -u origin <branch-name>
```

例:

```bash
git push -u origin feature/login
```

`-u` を付けると、以降は次だけでPushできます。

```bash
git push
```

---

## 最新状態を取得する — pull

```bash
git pull
```

Remoteから変更を取得して、現在のBranchへ反映します。作業開始時は基本的に:

```bash
git switch main
git pull
```

---

## 情報だけ取得する — fetch

```bash
git fetch
```

`fetch` はRemoteの情報を取得しますが、**現在のBranchには反映しません。**

```text
git fetch  →  Remoteの最新情報を取得（手元の作業には触らない）

git pull   →  Remoteの最新情報を取得 ＋ 現在のBranchへ反映
```

概念的には:

```text
git pull ≈ git fetch + 統合処理（merge）
```

「今どうなっているか知りたいだけ」なら `fetch` が安全です。

---

## Remoteを確認する — remote -v

```bash
git remote -v
```

```text
origin  https://github.com/Lumos-Programming/github-practice.git (fetch)
origin  https://github.com/Lumos-Programming/github-practice.git (push)
```

---

## 履歴を見る — log

```bash
git log
```

簡潔に:

```bash
git log --oneline
```

```text
42b91ad Add login API
318fd12 Fix database connection
04ab731 Initial commit
```

Branch構造も見る:

```bash
git log --oneline --graph --all
```

どこで分岐し、どこでMergeされたかが視覚的に分かります。
**Gitが分からなくなったときに一番効く可視化コマンド**です。

> `log` の表示が長いと `:` が出て止まります。`q` で終了できます。

---

## 変更を取り消す — restore

ファイルの変更そのものを取り消す:

```bash
git restore <file>
```

**変更内容が消えます。戻せません。** 実行前に `git diff` で中身を確認してください。

`git add` だけを取り消す（変更は残す）:

```bash
git restore --staged <file>
```

```text
git restore           → 編集内容を捨てる
git restore --staged  → Staging Areaから外すだけ（編集内容は残る）
```

---

## 一時退避する — stash

```bash
git stash
```

「Commitしたくないが、別のBranchを見たい」ときに使います。

```bash
git stash
git switch main
# 確認が済んだら
git switch feature/login
git stash pop
```

一覧:

```bash
git stash list
```

> `git stash pop` は「取り出して一覧から削除」、`git stash apply` は「取り出すが一覧に残す」です。

---

## 統合する — merge

現在いるBranchへ、別のBranchを統合します。

```bash
git merge <branch-name>
```

例:

```bash
git switch main
git merge feature/login
```

ただしLusyの通常開発では、

```text
Pull Request → Review → GitHub上でMerge
```

を原則とします。ローカルの `git merge` は、主に

- Conflictの解消
- 作業Branchに `main` の最新を取り込む（`git merge origin/main`）

ために使います。

---

## Commitを打ち消す — revert

```bash
git revert <commit-id>
```

例:

```bash
git revert 42b91ad
```

`revert` は履歴からCommitを消すのではなく、

> **そのCommitの変更を打ち消す新しいCommit**

を作ります。履歴が壊れないため、**共有済みのBranchでは必ずこちらを使います。**

---

## Commitを戻す — reset

`reset` は **履歴そのものを動かす** 操作です。

```bash
git reset --soft HEAD~1
```

直前のCommitを取り消しますが、変更内容はStaging Areaに残ります。
「Commitメッセージを間違えた」「Commitを分け直したい」ときに使います。

```bash
git reset --hard HEAD~1
```

こちらは Commit・Staging・Working Treeの変更を **まとめて捨てます。**

> ⚠️ `--hard` は変更を失う可能性が非常に高いコマンドです。
> このTraining Repositoryでは練習しますが、実Repositoryでは意味を理解せずに使わないでください。

```text
共有済みのBranch  → revert を使う
手元だけのBranch  → reset を使ってもよい
```

---

## GitHub CLI — gh

TerminalからGitHubを操作できます。**必須ではありません。**

```bash
gh auth login          # ログイン
gh pr create           # Pull Request作成
gh pr list             # 一覧
gh pr view --web       # ブラウザで開く
gh pr checkout 42      # 他人のPRを手元に取得
gh issue list          # Issue一覧
```

`gh pr checkout` は、**Reviewで実際にコードを動かして確認したいとき**に便利です。

---

次: [05 Conventions](05-conventions.md)
