#!/bin/bash
# Auto-resize panes for nic layout only (3 panes)
#
# nic layout:
#   - Right pane (AI):     50% width
#   - Left pane (editor):  65% width
#   - Bottom pane (term):  35% height

PANE_ID="$1"
PANE_LEFT="$2"
PANE_WIDTH="$3"
WIN_WIDTH="$4"

PANE_COUNT=$(tmux list-panes | wc -l | tr -d ' ')

# Only activate for nic layout (exactly 3 panes)
[ "$PANE_COUNT" -ne 3 ] && exit 0

if [ "$PANE_LEFT" -gt 0 ]; then
  # right pane (AI) focused
  tmux resize-pane -t "$PANE_ID" -x 50%
  TERM=$(tmux list-panes -F "#{pane_id} #{pane_left} #{pane_width}" | awk -v w="$WIN_WIDTH" '$2==0 && $3==w {print $1}')
  [ -n "$TERM" ] && tmux resize-pane -t "$TERM" -y 20%

elif [ "$PANE_WIDTH" -lt "$WIN_WIDTH" ]; then
  # left pane (editor) focused
  tmux resize-pane -t "$PANE_ID" -x 65%
  TERM=$(tmux list-panes -F "#{pane_id} #{pane_left} #{pane_width}" | awk -v w="$WIN_WIDTH" '$2==0 && $3==w {print $1}')
  [ -n "$TERM" ] && tmux resize-pane -t "$TERM" -y 20%

else
  # full-width bottom pane (terminal) focused
  tmux resize-pane -t "$PANE_ID" -y 35%
fi
