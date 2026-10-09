# 実習7: Commitを取り消す

[← 実習一覧](README.md)

**目的:** `revert` / `reset --soft` / `reset --hard` の違いと、使い分けを理解する
**目安:** 25分

この実習は捨ててよいBranchで行います。Pull Requestは作りません。

---

## 使い分けの結論（先に読む）

| 状況 | 使うもの | 理由 |
|---|---|---|
| すでにPushして共有されている | **`git revert`** | 履歴を壊さない。他人に影響しない |
| まだ手元だけ。Commitを直したい | `git reset --soft` | 変更を残したままCommitをやり直せる |
| まだ手元だけ。全部捨てたい | `git reset --hard` ⚠️ | 変更ごと消える |

```text
revert  →  打ち消す新しいCommitを「足す」（履歴は残る）
reset   →  Commitを「なかったこと」にする（履歴が動く）
```

---

## 準備

```bash
git switch main
git pull
git switch -c training/<your-name>-undo
```

---

# Part A: revert（安全な取り消し）

## Step 1: 練習用のCommitを作る

`members/<your-name>.md` の末尾に追加して保存します。

```markdown
## Revert Training

この行はrevertの練習で追加しました。
```

```bash
git add members/<your-name>.md
git commit -m "Add revert training"
```

## Step 2: Commit IDを確認する

```bash
git log --oneline
```

```text
42b91ad Add revert training
8f2c1ab Add Taro training profile
```

一番上の7桁の英数字が **Commit ID（ハッシュ）** です。

## Step 3: revertする

```bash
git revert 42b91ad
```

エディタが開いたら、そのまま保存して閉じます（メッセージは自動生成されています）。
開かせたくない場合は:

```bash
git revert --no-edit 42b91ad
```

## Step 4: 結果を確認する

```bash
git log --oneline
```

```text
c7d3e91 Revert "Add revert training"
42b91ad Add revert training
8f2c1ab Add Taro training profile
```

> **元のCommitは残っています。** その変更を打ち消す新しいCommitが積まれました。
> ファイルを開くと、追加した行は消えています。

```text
「なかったこと」にするのではなく、「取り消した事実」を履歴に残す。
```

これが、共有済みBranchで `revert` を使う理由です。

---

# Part B: reset --soft（Commitのやり直し）

## Step 5: 練習用のCommitを作る

またファイルに1行足して保存します。

```bash
git add members/<your-name>.md
git commit -m "aaaa"
```

**わざと雑なCommit Messageにしてください。** これを直します。

## Step 6: reset --soft する

```bash
git reset --soft HEAD~1
```

`HEAD~1` は「1つ前のCommit」という意味です。

## Step 7: 確認する

```bash
git log --oneline
```

`aaaa` のCommitが消えています。

```bash
git status
```

```text
Changes to be committed:
        modified:   members/taro.md
```

> **Commitは消えたが、変更内容はStaging Areaに残っています。**
> だから、そのままCommitし直せます。

## Step 8: Commitし直す

```bash
git commit -m "Add reset training note"
git log --oneline
```

まともなメッセージのCommitに置き換わりました。
**「Commitメッセージを間違えた」ときの標準的な直し方**です。

> なお、直前のCommitのメッセージだけを直すなら `git commit --amend -m "..."` が手軽です。
> どちらも **Push前のCommitにのみ**使ってください。

---

# Part C: reset --hard（⚠️ 全部捨てる）

> **このTraining Repositoryでのみ実行してください。**

## Step 9: 練習用のCommitを作る

またファイルに1行足して保存します。

```bash
git add members/<your-name>.md
git commit -m "Add hard reset training"
git log --oneline
```

## Step 10: reset --hard する

```bash
git reset --hard HEAD~1
```

## Step 11: 確認する

```bash
git log --oneline
git status
```

```text
nothing to commit, working tree clean
```

ファイルを開いてください。**追加した行は跡形もなく消えています。**
Commitも、Stagingも、Working Treeの変更も、すべて消えました。

---

# Part D: reflog（最後の命綱）

消えたように見えても、実は追える場合があります。

## Step 12: reflogを見る

```bash
git reflog
```

```text
9a1b2c3 (HEAD -> training/taro-undo) HEAD@{0}: reset: moving to HEAD~1
5d4e6f7 HEAD@{1}: commit: Add hard reset training
9a1b2c3 HEAD@{2}: commit: Add reset training note
```

`HEAD@{1}` に、消したはずのCommitが残っています。

## Step 13: 復旧してみる

```bash
git reset --hard "HEAD@{1}"
git log --oneline
```

> ⚠️ **Windows（PowerShell）の場合は `"HEAD@{1}"` のように引用符で囲んでください。**
> `stash@{0}` と同じ理由です。詳細は
> [03 Setup の「Windows（PowerShell）を使う場合の注意」](../docs/03-setup.md#7-windowspowershellを使う場合の注意) を参照してください。

**戻ってきました。**

> `reflog` はHEADが移動した履歴です。`reset --hard` で失敗しても、
> **Commitさえしていれば**ここから戻せることが多くあります。
>
> ただし過信は禁物です。`reflog` の記録は永久ではなく（既定で90日）、
> **一度もCommitしていない変更は `reflog` にも残りません。**
> やらかしたと思ったら、追加の操作をする前にまず `git reflog` を見てください。

---

## 後片付け

```bash
git switch main
git branch -D training/<your-name>-undo
```

---

## まとめ

```text
git revert <commit>        打ち消すCommitを足す。共有済みならこれ一択
git reset --soft HEAD~1    Commitを取り消す。変更は残る
git reset --hard HEAD~1    Commitも変更も捨てる ⚠️
git reflog                 やらかしたときに最初に見るもの
```

**判断基準はひとつです。**

> そのCommitを、**すでに他の人が持っているか？**
> Yes → `revert` / No → `reset` も使ってよい

---

## 完了

自分のIssueで、実習7のチェックを付けてください。
すべての実習が終わったら、Issueの最終チェックを埋めてCloseしてください。**お疲れさまでした。**
