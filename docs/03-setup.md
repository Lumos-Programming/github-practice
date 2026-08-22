# 03. 事前準備（初回のみ）

[← README](../README.md)

---

## 1. Gitが入っているか確認

```bash
git --version
```

例:

```text
git version 2.39.5
```

### バージョンに関する注意

本研修では `git switch` / `git restore` を使用します。これらは **Git 2.23 以降** のコマンドです。

```text
git version 2.22 以下 → 先にGitを更新してください
```

- macOS: `brew install git`
- Windows: [git-scm.com](https://git-scm.com/download/win) から最新版をインストール

---

## 2. ユーザー名を設定

Commitに記録される名前です。初回のみ設定します。

```bash
git config --global user.name "Your Name"
```

例:

```bash
git config --global user.name "Taro Yamada"
```

---

## 3. メールアドレスを設定

```bash
git config --global user.email "your-email@example.com"
```

> GitHubのアカウントに登録しているメールアドレスを使ってください。
> 別のアドレスにすると、CommitがGitHub上で自分のアカウントに紐づきません。
>
> メールアドレスを公開したくない場合は、GitHubの
> Settings → Emails → 「Keep my email addresses private」で表示される
> `12345678+username@users.noreply.github.com` 形式のアドレスを設定してください。

---

## 4. エディタを設定（重要）

Merge時やCommit時に、Gitがメッセージ入力用のエディタを自動で開くことがあります。
設定していないとVimが開き、**閉じ方が分からず固まる**ことがよくあります。

VS Codeを使う場合:

```bash
git config --global core.editor "code --wait"
```

Vimに慣れている場合はそのままで構いません。

> もしVimが開いてしまったら: `Esc` → `:wq` → `Enter` で保存して終了、
> `Esc` → `:q!` → `Enter` で保存せず終了です。

---

## 5. 設定を確認

```bash
git config --global user.name
git config --global user.email
git config --global core.editor
```

---

## 6. 改行コードの設定（任意・推奨）

WindowsとmacOS/Linuxで改行コードが違うため、設定していないと
「1行も直していないのにファイル全体が差分になる」ことがあります。

Windows:

```bash
git config --global core.autocrlf true
```

macOS / Linux:

```bash
git config --global core.autocrlf input
```

---

## 7. GitHubへの認証

Cloneやpush時に認証を求められます。おすすめは [GitHub CLI](https://cli.github.com/) です。

```bash
gh auth login
```

対話に従って `GitHub.com` → `HTTPS` → `Login with a web browser` を選べば、
以降 `git push` などで認証情報を聞かれなくなります。

GitHub CLIを使わない場合は、SSH鍵の登録、またはPersonal Access Token（PAT）での認証が必要です。

---

準備ができたら [実習1: CloneからPull Requestまで](../exercises/01-clone-to-pr.md) へ。
