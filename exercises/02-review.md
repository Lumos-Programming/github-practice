# 実習2: Pull Request Review

[← 実習一覧](README.md)

**目的:** Reviewする側・される側の両方を経験する
**目安:** 30分
**前提:** 自分のPull Requestが作成済み。他のメンバーのPull Requestが1件以上ある

書き方の基準は [05 Conventions](../docs/05-conventions.md#reviewのやり方) を参照してください。

---

## A. Reviewする側

### Step 1: 他のメンバーのPull Requestを開く

GitHubの **Pull requests** タブから、自分以外のPull Requestを1件選びます。

### Step 2: 変更内容を読む

**Files changed** タブを開きます。ここが実際に変更された差分です。

確認すること:

- [ ] PRの目的（タイトル・本文）と、実際の変更が一致しているか
- [ ] 意図しないファイルが入っていないか（`.env` / `.DS_Store` / `node_modules/`）
- [ ] Secretが含まれていないか
- [ ] 内容が読んで理解できるか
- [ ] CIが通っているか

### Step 3: 行コメントを1件付ける

差分の行番号の左に出る **＋** をクリックすると、その行にコメントできます。
**最低1件、Review Commentを書いてください。**

例:

```text
この項目、もう少し具体的に書くと他のメンバーにも伝わりやすそうです。どうでしょうか？
```

> 「人」ではなく「コード（内容）」について書きます。
> 指摘ではなく質問の形にすると、相手も返信しやすくなります。

### Step 4: Reviewを提出する

右上の **Review changes** から種類を選んで **Submit review**。

| 種類 | 意味 |
|---|---|
| Comment | コメントのみ。可否は判断しない |
| Approve | 問題なし。Mergeしてよい |
| Request changes | 修正が必要。直るまでMergeしない |

**研修では、まず `Request changes` または `Comment` を1回出してください。**
「指摘 → 修正 → 再Push」の流れを体験するのが目的です。

---

## B. Reviewされる側

### Step 5: 指摘を確認する

自分のPull Requestに通知が来ます。**Conversation** タブでコメントを読みます。

### Step 6: 修正する

**同じBranchで作業します。新しいPull Requestは作りません。**

```bash
git switch training/<your-name>
git status
```

ファイルを編集したら:

```bash
git diff
git add members/<your-name>.md
git commit -m "Update training profile"
git push
```

`-u` は初回Pushで設定済みなので、以降は `git push` だけでOKです。

### Step 7: Pull Requestを確認

GitHubに戻ると、**Commitが自動で追加されている**ことが確認できます。
これがPull Requestの仕組みです。

### Step 8: 指摘に返信する

対応したコメントに返信して、Reviewerに知らせます。

```text
ご指摘ありがとうございます。修正しました。
```

対応が完了したコメントは **Resolve conversation** を押して閉じます。

### Step 9: 再Reviewを依頼する

Reviewer名の横にある 🔄 アイコン（Re-request review）を押します。

---

## C. Merge

Reviewで **Approve** をもらったら、Pull Request作成者がMergeします。

1. **Merge pull request** をクリック
2. **Confirm merge**
3. **Delete branch** をクリックして、Remoteの作業Branchを削除

> Mergeが押せない場合は、Approveが足りないかCIが落ちています。画面の指示を読んでください。

### 手元のBranchも片付ける

```bash
git switch main
git pull
git branch -d training/<your-name>
```

`-d` で削除できるのは「Mergeが済んでいるBranch」だけです。
つまり **`-d` が通ったこと自体が、Mergeできている証拠**になります。

---

## 完了

自分のIssueで、実習2のチェックを付けてください。

次: [実習3: PullとFetch](03-pull-fetch.md)
