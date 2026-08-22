# 実習一覧

[← README](../README.md)

上から順に進めてください。進捗は **あなた専用のIssue** のチェックリストで管理します。

| # | 実習 | 目安 | 学ぶこと |
|---|---|---|---|
| 1 | [CloneからPull Requestまで](01-clone-to-pr.md) | 40分 | clone / switch -c / add / commit / push / PR |
| 2 | [Pull Request Review](02-review.md) | 30分 | Review / Comment / 指摘対応の追加Push / Merge |
| 3 | [PullとFetch](03-pull-fetch.md) | 15分 | fetchとpullの違い / log --graph |
| 4 | [変更を取り消す](04-restore.md) | 15分 | restore / restore --staged |
| 5 | [Stash](05-stash.md) | 15分 | 作業途中の一時退避 |
| 6 | [Conflictを解消する](06-conflict.md) | 40分 | Conflictの発生と解消 |
| 7 | [Commitを取り消す](07-undo-commit.md) | 25分 | revert / reset --soft / reset --hard |

---

## 実習1〜2は他のメンバーと足並みが揃っている必要があります

- **実習2（Review）** は、他のメンバーのPull Requestが1件以上ある状態で行います
- **実習3（Pull / Fetch）** は、誰かのPull Requestが `main` にMergeされた後に行います
- **実習6（Conflict）** は1人でも進められます（Seed Branchを使用）。ペアでも実施できます

実習4・5・7は自分のペースで進めて構いません。

---

## 共通ルール

- 実習用のBranchは `training/<your-name>-<目的>` の形式で作ります
- 迷ったら [docs/06-troubleshooting.md](../docs/06-troubleshooting.md)
- **失敗して構いません。** ここは壊してよいRepositoryです
