# 実習6: Conflictを解消する

[← 実習一覧](README.md)

**目的:** Conflictを自分の手で起こし、自分の手で解消する
**目安:** 40分

---

## はじめに

**Conflictは異常ではありません。** 複数人で同じコードを編集していれば必ず起きます。
Gitが「どちらの変更を採用すべきか判断できない」と正直に申告している状態です。

重要なのは、

> **Conflictを恐れず、内容を確認して正しく解消できること**

です。Gitが壊れたわけでも、あなたがミスしたわけでもありません。

この実習には2つのパートがあります。

- **Part A（必須・1人で実施）** — Seed Branchを使って確実にConflictを起こす
- **Part B（任意・2人1組）** — 実務に近い形でPull Request経由のConflictを体験する

---

# Part A: 1人でConflictを起こす（必須）

このRepositoryには、Conflictを起こすための `seed/conflict` というBranchが用意されています。
`conflict-training/solo.md` の同じ行が、`main` とは違う内容に書き換えられています。

## Step 1: 準備

```bash
git switch main
git pull
git switch -c training/<your-name>-conflict
```

## Step 2: 現在の中身を確認する

```bash
cat conflict-training/solo.md
```

次の行があります。

```text
Message: Hello
```

## Step 3: 自分の変更を加えてCommitする

`conflict-training/solo.md` を開き、その行を自分の名前入りに書き換えます。

```text
Message: Hello from Taro
```

```bash
git add conflict-training/solo.md
git commit -m "Update conflict training message"
```

## Step 4: Seed Branchを取り込む

```bash
git fetch
git merge origin/seed/conflict
```

次のように表示されれば **成功** です。

```text
Auto-merging conflict-training/solo.md
CONFLICT (content): Merge conflict in conflict-training/solo.md
Automatic merge failed; fix conflicts and then commit the result.
```

> ここで慌ててコマンドを打たないでください。**まず `git status` です。**

## Step 5: 状態を確認する

```bash
git status
```

```text
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   conflict-training/solo.md
```

`git status` が、**次に何をすればいいかを全部書いてくれています。**
Conflictで固まったときは、この出力を落ち着いて読んでください。

## Step 6: ファイルを開く

```bash
cat conflict-training/solo.md
```

こうなっています。

```text
<<<<<<< HEAD
Message: Hello from Taro
=======
Message: Hello from Seed
>>>>>>> origin/seed/conflict
```

### 読み方

```text
<<<<<<< HEAD
    ここから下が「今いる自分のBranch」の内容
=======
    ここから下が「取り込もうとしている側」の内容
>>>>>>> origin/seed/conflict
```

## Step 7: 人間が正しい内容に直す

Gitは判断できません。**あなたが決めます。** 選択肢は3つです。

1. 自分の変更を採用する
2. 相手の変更を採用する
3. 両方を踏まえた内容にする（実務ではこれが多い）

ここでは3を選びます。ファイル全体を次のように書き換えてください。

```text
Message: Hello from Taro and Seed
```

> **Conflict Marker（`<<<<<<<` / `=======` / `>>>>>>>`）は3本とも必ず削除します。**
> 消し忘れたままCommitするのは、Conflict関連で最も多い事故です。

## Step 8: 解消したことを確認する

```bash
git diff
```

マーカーが残っていないか、目で確認してください。念のため検索もできます。

```bash
grep -rn "<<<<<<<\|>>>>>>>\|=======" conflict-training/solo.md
```

**何も表示されなければOK**です。

## Step 9: 解消済みとしてマークする

```bash
git add conflict-training/solo.md
git status
```

`All conflicts fixed but you are still merging.` に変われば成功です。

## Step 10: Merge Commitを作る

```bash
git commit --no-edit
```

> `--no-edit` を付けないとエディタが開きます（Gitが用意したMergeメッセージの確認画面です）。
> 開いてしまった場合: VS Codeなら保存して閉じる、Vimなら `Esc` → `:wq` → `Enter`。

## Step 11: 結果を確認する

```bash
git log --oneline --graph --all
```

2本の線が合流している様子が見えます。**これがMergeです。**

```bash
git push -u origin training/<your-name>-conflict
```

## Step 12: 後片付け

**このBranchはPull Requestを作らず、Mergeもしません。**
（`conflict-training/solo.md` を元のままにしておかないと、次に研修を受ける人がConflictを起こせません）

```bash
git switch main
git branch -D training/<your-name>-conflict
git push origin --delete training/<your-name>-conflict
```

> ここは未Mergeなので `-d` では削除できません。**捨ててよいと分かっている**ので `-D` を使います。
> 「意味が分かっていれば `-D` を使ってよい」という一例です。

自分のIssueに、Step 11の `git log --oneline --graph --all` の出力を貼って報告してください。

---

## やり直したくなったら

Conflictの途中で分からなくなったら、いつでも中止できます。

```bash
git merge --abort
```

Merge開始前の状態に完全に戻ります。**焦って `reset --hard` を打つ必要はありません。**
`--abort` を知っているだけで、Conflictはかなり怖くなくなります。

---

# Part B: 2人1組でConflictを起こす（任意）

実務に近い形です。管理者からペア番号（`01` など）を割り当ててもらってください。
以下、2人を **Aさん** / **Bさん** とします。使うファイルは `conflict-training/pair-01.md` です。

## Step 1: 2人とも、それぞれBranchを作る

```bash
git switch main
git pull
git switch -c training/<your-name>-pair
```

## Step 2: 2人とも、同じ行を編集する

`conflict-training/pair-01.md` の

```text
Message: Hello
```

を、Aさんは

```text
Message: Hello from A
```

Bさんは

```text
Message: Hello from B
```

に書き換えます。

## Step 3: 2人ともCommit・Push・Pull Request作成

```bash
git add conflict-training/pair-01.md
git commit -m "Update pair-01 message"
git push -u origin training/<your-name>-pair
```

GitHubで2人ともPull Requestを作成します。

## Step 4: AさんのPull Requestを先にMergeする

BさんがReviewしてApprove、AさんがMergeします。

## Step 5: BさんのPull Requestを見る

GitHubに次の表示が出ます。

```text
This branch has conflicts that must be resolved
```

**この状態のPull Requestは、実務でよく遭遇します。**

## Step 6: Bさんが手元で解消する

```bash
git switch training/<your-name>-pair
git fetch
git merge origin/main
```

Conflictが発生します。あとは **Part AのStep 5〜10とまったく同じ手順** です。

```bash
git status
# ファイルを直してマーカーを消す
git add conflict-training/pair-01.md
git commit --no-edit
git push
```

## Step 7: Pull Requestを確認する

GitHubに戻ると、警告が消えてMergeできるようになっています。
AさんがReviewしてApprove、BさんがMergeして完了です。

Merge後は2人とも後片付けをします。

```bash
git switch main
git pull
git branch -d training/<your-name>-pair
```

---

## まとめ

```text
1. Conflictが出たら、まず  git status
2. ファイルを開いて、人間が正しい内容を決める
3. マーカー <<<<<<< ======= >>>>>>> を3本とも消す
4. git add でマーク
5. git commit --no-edit
6. 分からなくなったら git merge --abort で最初からやり直す
```

**Conflictの解消に「正解のコマンド」はありません。** 正しい中身を決めるのは人間です。
Gitは「ここは人間が決めてください」と言っているだけです。

---

## 完了

自分のIssueで、実習6のチェックを付けてください。

次: [実習7: Commitを取り消す](07-undo-commit.md)
