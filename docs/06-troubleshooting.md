# 06. 困ったときの確認順序 / 危険な操作

[← README](../README.md)

---

## 大原則

Gitで問題が起きたら、**むやみにコマンドを実行しないでください。**

状態が分からないまま `git reset --hard` や `git push --force` を実行することが、
Gitで作業を失う最大の原因です。まず「今どうなっているか」を確認します。

---

## 確認の順序

```bash
git status                        # 1. 今どのBranch？ 未Commitの変更は？
git branch                        # 2. Branchの一覧と現在地
git log --oneline --graph --all   # 3. 履歴と分岐の形
git diff                          # 4. 変更の中身
git remote -v                     # 5. Remoteの設定
git fetch                         # 6. Remoteの最新情報を取得（手元は変えない）
```

### 自分に問う順番

```text
1. 今どのBranchにいる？
        ↓
2. 未Commitの変更はある？
        ↓
3. Stagingされている？
        ↓
4. 最近どのCommitをした？
        ↓
5. LocalとRemoteの状態は？
        ↓
6. 何をしようとして問題が起きた？
```

ここまで確認できていれば、質問するときも状況を正確に伝えられます。
Issueで質問するときは `git status` と `git log --oneline --graph --all` の出力を貼ってください。

---

## よくある状況と対処

### Branchを間違えて作業してしまった

まだCommitしていないなら、`switch` するだけで変更は付いてきます。

```bash
git status          # 変更内容を確認
git switch -c feature/correct-branch
```

移動できないと言われたら `git stash` で退避してから移動し、`git stash pop` で戻します。

### 間違ったファイルを `git add` してしまった

```bash
git restore --staged <file>
```

### Commitメッセージを間違えた（まだPushしていない）

```bash
git commit --amend -m "正しいメッセージ"
```

**Push済みのCommitには使わないでください。** 履歴が書き換わります。

### `git pull` したらConflictが出た

異常ではありません。[実習6](../exercises/06-conflict.md) の手順で解消してください。

```bash
git status          # どのファイルがConflictしているか確認
```

### Merge / Pull の途中で、やっぱりやめたい

```bash
git merge --abort
```

Merge開始前の状態に戻ります。

### PowerShellで `stash@{0}` や `HEAD@{1}` がエラーになる

PowerShellは `@{` を自分の記法として解釈します。引用符で囲んでください。

```powershell
git stash show -p "stash@{0}"
git reset --hard "HEAD@{1}"
```

引用符を付けた形は macOS / Linux / Git Bash でもそのまま動きます。
詳細は [03 Setup](03-setup.md#7-windowspowershellを使う場合の注意) を参照してください。

### 何が起きたか分からない / 作業を失ったかもしれない

```bash
git reflog
```

`reflog` はHEADが移動した履歴です。**`reset --hard` の直後でも、ここから戻せることがあります。**
慌てて追加の操作をする前に、まず `reflog` を見てください。

---

## 危険な操作

以下は強力ですが、誤ると変更や履歴を失います。

### git reset --hard

```bash
git reset --hard
```

Working Treeの変更まで消えます。Commitしていない作業は基本的に戻せません。

### git branch -D

```bash
git branch -D <branch>
```

未MergeのBranchでも強制削除します。まず `-d` を使ってください。

### git push --force

```bash
git push --force
```

Remoteの履歴を書き換えます。他人の作業を消す可能性があります。

> **共有Branch、特に `main` では原則使用しないでください。**
> どうしても必要な場合は `--force-with-lease` を使い、事前にチームへ共有します。

### git clean -fd

追跡されていないファイルを削除します。`.gitignore` されたファイルは残りますが、
新規作成してまだ `add` していないファイルは消えます。まず `-n`（確認のみ）で試してください。

```bash
git clean -nd    # 何が消えるか表示するだけ
```

### rm と Git は別物

```bash
rm file
```

これはファイルそのものを削除します。**Commit済みならGitで戻せますが、未Commitなら戻せません。**

> 「Gitが必ず何でも復元してくれる」とは考えないでください。
> Gitが守ってくれるのは、**Commitした内容だけ**です。

---

## まとめ

```text
分からない → git status
履歴が知りたい → git log --oneline --graph --all
やらかした → git reflog
Merge をやめたい → git merge --abort
```

---

次: [99 Cheatsheet](99-cheatsheet.md)
