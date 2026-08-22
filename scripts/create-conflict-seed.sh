#!/usr/bin/env bash
#
# 実習6 Part A 用の Seed Branch (seed/conflict) を作成／再作成します。
#
#   main               : conflict-training/solo.md → "Message: Hello"
#   seed/conflict      : conflict-training/solo.md → "Message: Hello from Seed"
#
# この差分があることで、研修者は
#   git merge origin/seed/conflict
# を実行するだけで確実にConflictを起こせます。
#
# 使い方（管理者のみ）:
#   ./scripts/create-conflict-seed.sh
#
set -euo pipefail

BRANCH="seed/conflict"
FILE="conflict-training/solo.md"
FROM="Message: Hello"
TO="Message: Hello from Seed"

cd "$(git rev-parse --show-toplevel)"

# --- 事前チェック -----------------------------------------------------------

if [ -n "$(git status --porcelain)" ]; then
  echo "error: 未Commitの変更があります。先にCommitまたはstashしてください。" >&2
  git status --short >&2
  exit 1
fi

ORIGINAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
cleanup() { git switch "$ORIGINAL_BRANCH" >/dev/null 2>&1 || true; }
trap cleanup EXIT

echo "==> main を最新化します"
git switch main
git pull --ff-only

if ! grep -qF "$FROM" "$FILE"; then
  echo "error: main 側の $FILE に '$FROM' の行がありません。" >&2
  echo "       main の $FILE が書き換えられている可能性があります。元に戻してください。" >&2
  exit 1
fi

# --- 確認 -------------------------------------------------------------------

if git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1; then
  echo ""
  echo "⚠️  origin に $BRANCH が既に存在します。"
  echo "    このスクリプトは $BRANCH を作り直し、force push で上書きします。"
  echo ""
  read -r -p "続行しますか? [y/N] " ans
  case "$ans" in
    [yY]) ;;
    *) echo "中止しました。"; exit 0 ;;
  esac
fi

# --- Seed Branch を作る -----------------------------------------------------

echo "==> $BRANCH を main から作成します"
git branch -D "$BRANCH" >/dev/null 2>&1 || true
git switch -c "$BRANCH"

# macOS / GNU 両対応のため sed -i は使わない
tmp="$(mktemp)"
FROM="$FROM" TO="$TO" awk '{ if ($0 == ENVIRON["FROM"]) print ENVIRON["TO"]; else print }' "$FILE" > "$tmp"
mv "$tmp" "$FILE"

if ! grep -qF "$TO" "$FILE"; then
  echo "error: 置換に失敗しました。" >&2
  exit 1
fi

git add "$FILE"
git commit -m "Seed: change solo.md message for conflict training"

echo "==> origin へ push します"
git push --force-with-lease -u origin "$BRANCH"

git switch main

echo ""
echo "✅ 完了しました。"
echo ""
echo "   研修者は次のコマンドでConflictを起こせます:"
echo "     git switch -c training/<name>-conflict"
echo "     # conflict-training/solo.md の Message: 行を書き換えてCommit"
echo "     git fetch"
echo "     git merge origin/seed/conflict"
echo ""
echo "   ※ GitHubのBranch Protectionで seed/* を保護対象に含めている場合は、"
echo "      一時的に解除してから実行してください。"
