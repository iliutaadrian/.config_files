#!/usr/bin/env bash
# Aggregate every custom shortcut from the config (tmux binds, zsh aliases,
# zsh functions) into one searchable list. Pipes through fzf when interactive.
#
# Descriptions come from a trailing  #@ Some description  tag on the line
# (for functions: the # comment line directly above the definition).
# Without a tag, the raw command is shown instead.

set -euo pipefail

CONFIG="${CONFIG_DIR:-$HOME/config}"
TMUX_CONF="$CONFIG/.tmux.conf"
ALIASES="$CONFIG/zsh/aliases"
FUNCTIONS="$CONFIG/zsh/functions"

# ANSI colors
C_SEC=$'\033[1;33m'   # section header
C_KEY=$'\033[1;36m'   # key / name
C_DIM=$'\033[2;37m'   # raw command (dimmed)
C_RST=$'\033[0m'

emit() {
  # reads "KEY\tDESC\tRAW" lines on stdin; $1 = section label
  printf '%s%s%s\n' "$C_SEC" "── $1 ──" "$C_RST"
  awk -F'\t' -v ck="$C_KEY" -v cd="$C_DIM" -v cr="$C_RST" '{
    desc=$2; raw=$3
    if (desc=="") { desc=raw; raw="" }
    line=sprintf("  %s%-16s%s %-46s", ck, $1, cr, desc)
    if (raw!="") line=line sprintf(" %s%s%s", cd, raw, cr)
    print line
  }'
}

dump() {
  # --- tmux key bindings ---
  # Description = trailing "#@ desc" on the bind line, else a "#@ desc" comment
  # line directly above it (used for multi-line binds).
  if [[ -f "$TMUX_CONF" ]]; then
    awk '
      /^[[:space:]]*#@/ {
        p=index($0,"#@"); pend=substr($0,p+2); sub(/^[[:space:]]+/,"",pend); next
      }
      /^[[:space:]]*bind(-key)?[[:space:]]/ {
        desc=""
        d=index($0,"#@")
        if (d>0) { desc=substr($0,d+2); sub(/^[[:space:]]+/,"",desc); $0=substr($0,1,d-1) }
        else if (pend!="") desc=pend
        pend=""
        $1=""                            # drop bind / bind-key
        i=2; table=""
        while (i<=NF) {
          if ($i=="-r" || $i=="-n") { i++; continue }
          if ($i=="-T") { table=$(i+1); i+=2; continue }
          break
        }
        key=$i
        action=""
        for (j=i+1;j<=NF;j++) action=action (action==""?"":" ") $j
        sub(/[[:space:]]+$/,"",action)
        if (table!="") next                  # skip copy-mode / mouse binds
        if (action ~ /^resize-pane/) next     # skip basic h/j/k/l/m resizing
        if (action=="send-prefix") next
        printf "%s\t%s\t%s\n", key, desc, action
        next
      }
      { pend="" }                            # any other line clears pending desc
    ' "$TMUX_CONF" \
      | emit "tmux  (prefix = C-s)"
    echo
  fi

  # --- zsh aliases ---
  if [[ -f "$ALIASES" ]]; then
    grep -hE '^[[:space:]]*alias ' "$ALIASES" "$FUNCTIONS" 2>/dev/null \
      | awk '{
          desc=""
          d=index($0,"#@")
          if (d>0) { desc=substr($0,d+2); sub(/^[[:space:]]+/,"",desc); $0=substr($0,1,d-1) }
          sub(/^[[:space:]]*alias[[:space:]]+/,"")
          sub(/[[:space:]]+$/,"")
          eq=index($0,"=")
          name=substr($0,1,eq-1)
          val=substr($0,eq+1)
          printf "%s\t%s\t%s\n", name, desc, val
        }' \
      | emit "aliases"
    echo
  fi

  # --- zsh functions (from both the functions file and inline ones in aliases) ---
  # Description = trailing "#@ desc" on the def line, else the "#" comment above.
  if [[ -f "$FUNCTIONS" || -f "$ALIASES" ]]; then
    awk '
      /^[[:space:]]*#/ {
        c=$0; sub(/^[[:space:]]*#[[:space:]]?/,"",c); sub(/^@[[:space:]]*/,"",c)
        pend=c; next
      }
      /^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_-]*\(\)/ {
        name=$0; sub(/^[[:space:]]*/,"",name); sub(/\(\).*/,"",name)
        if (name in seen) { pend=""; next }
        seen[name]=1
        desc=""
        d=index($0,"#@")
        if (d>0) { desc=substr($0,d+2); sub(/^[[:space:]]+/,"",desc) }
        else desc=pend
        pend=""
        printf "%s\t%s\t\n", name, desc
        next
      }
      { pend="" }
    ' "$FUNCTIONS" "$ALIASES" | emit "functions"
  fi
}

if [[ "${1:-}" == "--raw" ]] || ! command -v fzf >/dev/null 2>&1; then
  dump
else
  dump | fzf --ansi --no-sort --reverse \
             --header='custom shortcuts — type to filter' --prompt='cheat> '
fi
