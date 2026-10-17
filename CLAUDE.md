# Shiloh Living — marketing site

Static HTML/CSS/JS site for https://shilohliving.app. No build step.

The rental management app is a **separate repo** (`shilohliving`) and lives at
https://hub.shilohliving.app — the "Login" button links there.

## Where it runs

- Namecheap shared hosting (cPanel, server353), web root `~/public_html`.
- SSH: `ssh -i ~/.ssh/namecheap_ed25519 -p 21098 shilzikx@server353.web-hosting.com`
- Don't touch `~/shilohliving_hub` or `~/hub.shilohliving.app` from here — that's the app.

## Must keep

- `.htaccess` redirect block: old app links (`/api/*`, `?type=reset|verify`,
  `?register=tenant`) are sent to the hub. Password-reset/verify emails depend on it.
- `sw.js`: unregisters the old app service worker for returning visitors.

## Workflow — every change goes local → GitHub → live

1. Commit the change.
2. Run `scripts/deploy.sh` — refuses with uncommitted changes, pushes to GitHub, uploads
   the committed tree to `~/public_html`, and checks the homepage returns 200.

Deploys only add/overwrite files; to remove a page, delete it on the server too.
Don't edit files directly on the server — the next deploy would overwrite them.
