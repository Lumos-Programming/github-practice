# 実習4: 変更を取り消す

[← 実習一覧](README.md)

**目的:** `git restore` と `git restore --staged` の違いを体で覚える
**目安:** 15分

この実習のBranchはPull Requestを作りません。練習が終わったら削除します。

---

## 準備

```bash
git switch main
git pull
git switch -c training/<your-name>-restore
```

---

## Part A: 編集内容そのものを捨てる

### Step 1: ファイルを変更する

`members/<your-name>.md` の末尾に、適当な行を追加して保存します。

```markdown
この行は練習で追加した行です。
```

### Step 2: 確認する

```bash
git status
git diff
```

`git diff` に追加した行が `+` で表示されます。

### Step 3: 取り消す

```bash
git restore members/<your-name>.md
```

### Step 4: 確認する

```bash
git diff
git status
```

何も表示されなくなります。エディタでファイルを開くと、**追加した行が消えています。**

> ⚠️ **`git restore` した内容は戻せません。**
> `git status` や `git diff` で中身を確認してから実行する癖をつけてください。

---

## Part B: Stagingだけ取り消す

### Step 5: もう一度変更する

同じファイルにまた適当な行を追加して保存します。

### Step 6: Stagingする

```bash
git add members/<your-name>.md
git status
```

`Changes to be committed` に入っていることを確認します。

### Step 7: Stagingだけ外す

```bash
git restore --staged members/<your-name>.md
```

### Step 8: 確認する

```bash
git status
```

`Changes not staged for commit` に戻っています。

```bash
git diff
```

**追加した行はまだ残っています。** ここがPart Aとの決定的な違いです。

---

## まとめ

```text
git restore <file>            → 編集内容を捨てる（戻せない）⚠️
git restore --staged <file>   → Stagingから外すだけ（編集内容は残る）
```

```text
[Working Tree] --- git add ---> [Staging Area] --- git commit ---> [Local Repository]
      ↑                                ↑
  git restore <file>          git restore --staged <file>
  （編集を捨てる）              （addを取り消す）
```

`git status` は、この2つのコマンドをちゃんと教えてくれています。
一度、出力の文面をよく読んでみてください。

---

## 後片付け

```bash
git restore members/<your-name>.md   # 残っている変更を捨てる
git switch main
git branch -d training/<your-name>-restore
```

`-d` で「未Mergeだ」と拒否された場合は、Commitが残っています。
この練習Branchは捨ててよいので、その場合のみ `-D` を使ってください。

---

## 完了

自分のIssueで、実習4のチェックを付けてください。

次: [実習5: Stash](05-stash.md)
