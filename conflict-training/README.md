# conflict-training/

[実習6: Conflictを解消する](../exercises/06-conflict.md) で使うファイルです。

## ファイルの役割

| ファイル | 用途 |
|---|---|
| `solo.md` | **Part A（1人で実施）** 用。`seed/conflict` Branchと衝突するように作られています |
| `pair-01.md` 〜 `pair-05.md` | **Part B（2人1組）** 用。ペアごとに1ファイルを使います |

## ⚠️ 重要

**`solo.md` の内容を変更するPull Requestは、`main` にMergeしないでください。**

`solo.md` は「`main` 側が `Message: Hello`、`seed/conflict` 側が `Message: Hello from Seed`」
という状態を保つことで、誰でも確実にConflictを起こせるようになっています。
`main` 側を書き換えてしまうと、**次に研修を受ける人が実習できなくなります。**

Part Aの練習Branchは、Pull Requestを作らずに削除してください。

## 仕込みが壊れてしまったら

管理者が次のスクリプトで `seed/conflict` Branchを作り直せます。

```bash
./scripts/create-conflict-seed.sh
```

詳細は [docs/admin-setup.md](../docs/admin-setup.md) を参照してください。
