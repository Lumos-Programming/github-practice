# 実習3: PullとFetch

[← 実習一覧](README.md)

**目的:** `fetch` と `pull` の違いを、手を動かして理解する
**目安:** 15分
**前提:** 他のメンバーのPull Requestが1件以上Mergeされている

---

## Step 1: mainへ移動する（まだpullしない）

```bash
git switch main
git status
```

`Your branch is up to date with 'origin/main'.` と出るはずです。
**これは「GitHubの最新と同じ」という意味ではありません。**
「手元が知っている `origin/main` と同じ」という意味です。ここが最初の落とし穴です。

---

## Step 2: fetchする

```bash
git fetch
```

Remoteの最新情報を取得します。**手元のファイルは1つも変わりません。**

---

## Step 3: もう一度statusを見る

```bash
git status
```

今度はこう変わっているはずです。

```text
Your branch is behind 'origin/main' by 3 commits, and can be fast-forwarded.
```

> `fetch` によって「GitHub側が進んでいる」ことが分かりました。
> **でも手元のファイルはまだ古いままです。** これが `fetch` の役割です。

---

## Step 4: 差分を先に見る

反映する前に、何が入ってくるのかを確認できます。

```bash
git log --oneline main..origin/main
```

```bash
git diff main origin/main --stat
```

> 実務では、`pull` する前にこれを見る習慣があると事故が減ります。

---

## Step 5: Remote Branchの一覧を見る

```bash
git branch -a
```

```text
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
  remotes/origin/seed/conflict
  remotes/origin/training/hanako
```

`remotes/` から始まるものがRemote Branchです。

---

## Step 6: pullする

```bash
git pull
```

今度は **手元のファイルが実際に更新されます。**

---

## Step 7: 結果を確認する

```bash
ls members/
```

他のメンバーのファイルが増えているはずです。

```bash
git log --oneline
```

```bash
git log --oneline --graph --all
```

`--graph --all` では、Branchがどこから分岐し、どこでMergeされたかが線で見えます。
**Gitで迷子になったとき、一番効く可視化コマンドです。** 表示を抜けるには `q` を押します。

---

## まとめ

```text
git fetch  →  Remoteの最新「情報」を取得する。手元のファイルは変わらない
git pull   →  取得したうえで、現在のBranchに「反映」する

git pull ≈ git fetch + merge
```

| こうしたいとき | 使うもの |
|---|---|
| 今GitHub側がどうなっているか知りたいだけ | `git fetch` |
| 作業を始めるので手元を最新にしたい | `git pull` |
| 作業中だが、`main` の最新を取り込みたい | `git fetch` → `git merge origin/main` |

---

## 完了

自分のIssueで、実習3のチェックを付けてください。

次: [実習4: 変更を取り消す](04-restore.md)
