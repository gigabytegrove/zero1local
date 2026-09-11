# Notifications

Zero1Local has a Notification Center and optional outbound delivery methods.

Depending on the configured provider, v1.2 can expose settings for:

- SMTP email
- generic webhook
- ntfy
- Gotify
- Telegram
- Discord webhook
- Slack webhook
- Microsoft Teams webhook
- Pushover

Delivery can be filtered by severity where the UI exposes that option.

## Secrets

Notification credentials are secrets. Never publish SMTP passwords, bearer tokens, bot tokens or webhook URLs containing credentials in a public issue.

Use the built-in provider test action when available before diagnosing a scheduler/task problem.
