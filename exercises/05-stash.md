# 実習5: Stash（作業の一時退避）

[← 実習一覧](README.md)

**目的:** Commitしたくない作業途中の変更を、安全に退避して戻す
**目安:** 15分

---

## どういうときに使うのか

```text
feature/login を作業中
        ↓
「今すぐ本番のバグを見てほしい」と言われた
        ↓
でも中途半端なのでCommitしたくない
        ↓
git stash
```

Branchを移動しようとすると、Gitに止められることがあります。

```text
error: Your local changes to the following files would be overwritten by checkout
```

このときに使うのが `stash` です。

---

## 準備

```bash
git switch main
git pull
git switch -c training/<your-name>-stash
```

---

## Step 1: ファイルを変更する

`members/<your-name>.md` の末尾に追加して保存します。

```markdown
## Stash Training

作業途中の状態です。
```

---

## Step 2: 状態を確認する

```bash
git status
git diff
```

---

## Step 3: 退避する

```bash
git stash
```

```text
Saved working directory and index state WIP on training/taro-stash: ...
```

---

## Step 4: 消えたことを確認する

```bash
git status
```

```text
nothing to commit, working tree clean
```

**変更が消えたように見えます。** でも失われてはいません。

エディタでファイルを開いて、追加した行がなくなっていることも確認してください。

---

## Step 5: 別のBranchへ移動できることを確認する

```bash
git switch main
git status
```

問題なく移動できます。これがstashの目的です。

```bash
git switch training/<your-name>-stash
```

---

## Step 6: 退避の一覧を見る

```bash
git stash list
```

```text
stash@{0}: WIP on training/taro-stash: 8f2c1ab Add Taro training profile
```

中身を見ることもできます。

```bash
git stash show -p stash@{0}
```

---

## Step 7: 戻す

```bash
git stash pop
```

---

## Step 8: 確認する

```bash
git status
git diff
```

**追加した行が戻っていれば成功です。**

```bash
git stash list
```

`pop` したので、一覧からは消えています。

---

## まとめ

| コマンド | 意味 |
|---|---|
| `git stash` | 変更を退避する |
| `git stash list` | 退避の一覧を見る |
| `git stash show -p` | 退避の中身を見る |
| `git stash pop` | 取り出して一覧から削除 |
| `git stash apply` | 取り出すが一覧に残す |
| `git stash drop` | 取り出さずに捨てる |

### 注意

- **stashは溜めないでください。** 何個も積むと、どれが何か分からなくなります
- 新規作成してまだ `add` していないファイルは、標準では退避されません（`git stash -u` が必要）
- 長期間の退避には向きません。長引くなら、作業Branchを作ってCommitするほうが安全です

---

## 後片付け

```bash
git restore members/<your-name>.md
git switch main
git branch -d training/<your-name>-stash
```

---

## 完了

自分のIssueで、実習5のチェックを付けてください。

次: [実習6: Conflictを解消する](06-conflict.md)
