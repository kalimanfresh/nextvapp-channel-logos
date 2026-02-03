#!/bin/bash

REPO_DIR="/var/www/nextv3/public/logos/github-repo"
CHANNELS_DIR="/var/www/nextv3/public/logos/channels"
LOG_FILE="/var/log/logo-sync.log"
CONFIG_FILE="/var/www/nextv3/public/logos/github-repo/scripts/.github-token"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Token file not found at $CONFIG_FILE"
    echo "Create it with: echo 'ghp_yourtoken' > $CONFIG_FILE && chmod 600 $CONFIG_FILE"
    exit 1
fi

GITHUB_TOKEN=$(cat "$CONFIG_FILE")

cd "$REPO_DIR" || exit 1

BEFORE_COUNT=$(ls logos/ 2>/dev/null | wc -l)

rsync -a --ignore-existing "$CHANNELS_DIR/" "$REPO_DIR/logos/"

AFTER_COUNT=$(ls logos/ | wc -l)
NEW_COUNT=$((AFTER_COUNT - BEFORE_COUNT))

if [ "$NEW_COUNT" -gt 0 ]; then
    log "Found $NEW_COUNT new logos to sync"

    php scripts/generate-index.php >> "$LOG_FILE" 2>&1

    git add logos/ index.json

    CHANGED=$(git diff --cached --name-only | wc -l)

    if [ "$CHANGED" -gt 0 ]; then
        git commit -m "Auto-sync: Added $NEW_COUNT new logos"

        git remote set-url origin "https://${GITHUB_TOKEN}@github.com/kalimanfresh/nextvapp-channel-logos.git"

        if git push origin main >> "$LOG_FILE" 2>&1; then
            log "Successfully pushed $NEW_COUNT new logos to GitHub"
            echo "Synced $NEW_COUNT new logos to GitHub"
        else
            log "ERROR: Failed to push to GitHub"
            echo "Error: Failed to push to GitHub"
            exit 1
        fi

        git remote set-url origin "https://github.com/kalimanfresh/nextvapp-channel-logos.git"
    else
        log "No changes to commit"
    fi
else
    log "No new logos to sync"
    echo "No new logos to sync"
fi
