#!/bin/bash

set -e

DOWNLOAD_DIR="/mnt/labnas_install/ISOs"
VERSION_FILE="$DOWNLOAD_DIR/last_versions.txt"
NTFY_URL="https://ntfy.maass.casa/ISO_Download"
TEST_MODE=false

# Testmodus aktivieren, wenn --test übergeben wurde
if [[ "$1" == "--test" ]]; then
  TEST_MODE=true
  echo "🧪 Testmodus aktiviert – keine Änderungen werden vorgenommen!"
fi

mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

echo "🔽 ISO-Download gestartet... Zielordner: $DOWNLOAD_DIR"
echo "========================================="

clean_old_versions() {
    pattern="$1"
    echo "🧹 Lösche alte ISOs für: $pattern"
    if ! $TEST_MODE; then
        rm -f ${pattern}-*.iso || true
    fi
}

# Vorherige Versionen laden
if [[ -f "$VERSION_FILE" ]]; then
    source "$VERSION_FILE"
fi

CHANGES_UBUNTU=""
CHANGES_MINT=""
CHANGES_CLONEZILLA=""
NEW_VERSIONS=()

{
############################
# 🟠 Ubuntu
############################
echo "➡️  Suche neueste Ubuntu-Version..."

UBUNTU_BASE="https://releases.ubuntu.com"
LATEST_UBUNTU=$(curl -s "$UBUNTU_BASE/" | grep -oP 'href="\K[0-9]{2}\.[0-9]{2}(?=/")' | sort -V | tail -1)
UBUNTU_ISO="ubuntu-$LATEST_UBUNTU-desktop-amd64.iso"
UBUNTU_URL="$UBUNTU_BASE/$LATEST_UBUNTU/$UBUNTU_ISO"

if [[ "$UBUNTU_OLD" != "$LATEST_UBUNTU" ]]; then
    clean_old_versions "ubuntu"
    echo "✅ Ubuntu $LATEST_UBUNTU"
    echo "📥 $UBUNTU_URL"
    if ! $TEST_MODE; then
        wget -c "$UBUNTU_URL" -O "ubuntu-$LATEST_UBUNTU.iso"
    fi
    CHANGES_UBUNTU="
    🟠 Ubuntu: ${UBUNTU_OLD:-(keine)} → $LATEST_UBUNTU"
    NEW_VERSIONS+=("ubuntu")
fi

############################
# 🟢 Linux Mint
############################
echo "➡️  Suche neueste Linux Mint-Version..."

MINT_BASE="https://mirrors.edge.kernel.org/linuxmint/stable"
LATEST_MINT=$(curl -s "$MINT_BASE/" | grep -oP 'href="\K[0-9.]+(?=/")' | sort -V | tail -1)
MINT_ISO="linuxmint-$LATEST_MINT-cinnamon-64bit.iso"
MINT_URL="$MINT_BASE/$LATEST_MINT/$MINT_ISO"

if [[ "$MINT_OLD" != "$LATEST_MINT" ]]; then
    clean_old_versions "linuxmint"
    echo "✅ Linux Mint $LATEST_MINT"
    echo "📥 $MINT_URL"
    if ! $TEST_MODE; then
        wget -c "$MINT_URL" -O "linuxmint-$LATEST_MINT.iso"
    fi
    CHANGES_MINT="
    🟢 Linux Mint: ${MINT_OLD:-(keine)} → $LATEST_MINT"
    NEW_VERSIONS+=("linuxmint")
fi

############################
# 🟣 Clonezilla
############################
echo "➡️  Suche neueste Clonezilla-Version..."

CLONEZILLA_BASE="https://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/"
CLONEZILLA_MIRROR="https://downloads.sourceforge.net/project/clonezilla/clonezilla_live_stable"
LATEST_CLONEZILLA=$(curl -s "$CLONEZILLA_BASE" | grep -oP 'clonezilla_live_stable/\K[0-9]+\.[0-9]+\.[0-9]+-[0-9]+' | sort -V | tail -1)

CLONEZILLA_ISO_NAME="clonezilla-live-$LATEST_CLONEZILLA-amd64.iso"
CLONEZILLA_URL="$CLONEZILLA_MIRROR/$LATEST_CLONEZILLA/$CLONEZILLA_ISO_NAME"

if [[ "$CLONEZILLA_OLD" != "$LATEST_CLONEZILLA" ]]; then
    clean_old_versions "clonezilla"
    echo "✅ Clonezilla $LATEST_CLONEZILLA"
    echo "📥 $CLONEZILLA_URL"
    if ! $TEST_MODE; then
        wget -c "$CLONEZILLA_URL" -O "$CLONEZILLA_ISO_NAME"
    fi
    CHANGES_CLONEZILLA="
    🟣 Clonezilla: ${CLONEZILLA_OLD:-(keine)} → $LATEST_CLONEZILLA"
    NEW_VERSIONS+=("clonezilla")
fi

############################
# 💾 Versionen speichern
############################
if ! $TEST_MODE; then
cat <<EOF > "$VERSION_FILE"
UBUNTU_OLD=$LATEST_UBUNTU
MINT_OLD=$LATEST_MINT
CLONEZILLA_OLD=$LATEST_CLONEZILLA
EOF
fi

############################
# 📢 Benachrichtigung
############################
if [[ ${#NEW_VERSIONS[@]} -gt 0 ]]; then
  if $TEST_MODE; then
    MESSAGE="🧪 Testmodus: Folgende ISOs wären aktualisiert worden:"
  else
    MESSAGE="Folgende ISOs wurden aktualisiert:"
  fi

  [[ -n "$CHANGES_UBUNTU" ]] && MESSAGE+="$CHANGES_UBUNTU"
  [[ -n "$CHANGES_MINT" ]] && MESSAGE+="$CHANGES_MINT"
  [[ -n "$CHANGES_CLONEZILLA" ]] && MESSAGE+="$CHANGES_CLONEZILLA"

  curl -s \
    -H "Title: $( $TEST_MODE && echo '🧪 Testlauf' || echo 'Neue ISO-Versionen verfügbar')" \
    -d "$MESSAGE" \
    "$NTFY_URL"

  echo "📣 Benachrichtigung gesendet."
else
  echo "✅ Keine neuen Versionen gefunden – keine Benachrichtigung nötig."
fi

echo "🎉 ISO-Download abgeschlossen."
} || {
  ERR_MSG="Fehler beim ISO-Download. Bitte Logs prüfen."
  echo "🚨 $ERR_MSG"
  if ! $TEST_MODE; then
    curl -s -H "Title: ISO Download fehlgeschlagen" -d "$ERR_MSG" "$NTFY_URL"
  fi
  exit 1
}

