/bin/bash

set -euo pipefail

PLIST_SRC="st.rio.controlled.plist"
PLIST_DST="${HOME}/Library/LaunchAgents/st.rio.controlled.plist"
DOMAIN="gui/$(id -u)"
LABEL="st.rio.controlled"

# 1) 配置
install -m 0644 "${PLIST_SRC}" "${PLIST_DST}"

# 2) 既存ジョブがあれば外す（エラーは無視）
launchctl bootout "${DOMAIN}" "${PLIST_DST}" 2>/dev/null || true

# 3) 読み込み
launchctl bootstrap "${DOMAIN}" "${PLIST_DST}"

# 4) 無効化されている可能性に備えて有効化
launchctl enable "${DOMAIN}/${LABEL}"

# 5) 状態表示
launchctl print "${DOMAIN}/${LABEL}"
