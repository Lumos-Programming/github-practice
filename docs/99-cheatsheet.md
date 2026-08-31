# 99. コマンド早見表

[← README](../README.md) / 詳しい解説は [04 Commands](04-commands.md)

---

## 毎日使う流れ

```bash
git switch main
git pull
git switch -c feature/xxx
# 開発する
git status
git diff
git add <file>
git commit -m "Add xxx"
git push -u origin feature/xxx
# GitHubでPull Request → Review → Merge
```

---

## Repository

| コマンド | 意味 |
|---|---|
| `git clone <URL>` | Repositoryを取得 |
| `git remote -v` | Remoteを確認 |

## 状態確認

| コマンド | 意味 |
|---|---|
| `git status` | **現在の状態を確認（困ったらこれ）** |
| `git diff` | 未Stagingの変更を見る |
| `git diff --staged` | Staging済みの変更を見る |
| `git log` | 履歴を見る |
| `git log --oneline` | 履歴を1行で見る |
| `git log --oneline --graph --all` | Branch構造ごと見る |
| `git reflog` | HEADの移動履歴（復旧用） |

## Branch

| コマンド | 意味 |
|---|---|
| `git branch` | Branch一覧 |
| `git branch -a` | Remoteも含めた一覧 |
| `git switch <branch>` | Branchを移動 |
| `git switch -c <branch>` | Branchを作成して移動 |
| `git branch -d <branch>` | Branchを削除 |
| `git branch -D <branch>` | 強制削除 ⚠️ |

## 変更を記録する

| コマンド | 意味 |
|---|---|
| `git add <file>` | Commit対象に追加 |
| `git add .` | まとめて追加（`status` で確認してから） |
| `git commit -m "<msg>"` | Commit |
| `git commit --no-edit` | メッセージ自動生成のままCommit |
| `git commit --amend -m "<msg>"` | 直前のCommitを修正（Push前のみ） |

## 同期する

| コマンド | 意味 |
|---|---|
| `git fetch` | Remoteの情報だけ取得 |
| `git pull` | 取得して現在のBranchへ反映 |
| `git push` | Push |
| `git push -u origin <branch>` | 初回Push |

## 取り消す

| コマンド | 意味 |
|---|---|
| `git restore <file>` | 編集内容を捨てる ⚠️ |
| `git restore --staged <file>` | Stagingから外す（編集は残る） |
| `git revert <commit>` | Commitを打ち消す新Commitを作る（安全） |
| `git reset --soft HEAD~1` | Commitだけ取り消す（変更は残る） |
| `git reset --hard HEAD~1` | Commitも変更も捨てる ⚠️⚠️ |

> Windows（PowerShell）では `stash@{0}` / `HEAD@{1}` のような `@{ }` を含む指定は
> `"stash@{0}"` のように引用符で囲んでください（[03 Setup](03-setup.md#7-windowspowershellを使う場合の注意)）。

## 一時退避

| コマンド | 意味 |
|---|---|
| `git stash` | 作業中の変更を退避 |
| `git stash list` | 退避一覧 |
| `git stash pop` | 取り出して一覧から削除 |
| `git stash apply` | 取り出すが一覧に残す |

## 統合

| コマンド | 意味 |
|---|---|
| `git merge <branch>` | 現在のBranchへ統合 |
| `git merge origin/main` | mainの最新を作業Branchへ取り込む |
| `git merge --abort` | Mergeを中止して元に戻す |

## GitHub CLI

| コマンド | 意味 |
|---|---|
| `gh auth login` | ログイン |
| `gh pr create` | Pull Request作成 |
| `gh pr list` | 一覧 |
| `gh pr view --web` | ブラウザで開く |
| `gh pr checkout <number>` | 他人のPRを手元に取得 |

---

## ⚠️ 実行前に一呼吸

```bash
git reset --hard
git push --force
git branch -D
git clean -fd
```

この4つは、**`git status` で状態を確認してから**実行してください。
