#!/bin/bash

# To keep it synced, you can either:
#  1. Symlink: ln -sf dotfiles/statusline-command.sh ~/.claude/statusline-command.sh
#  2. Or update settings.json to point to the dotfiles path directly: "command": "bash dotfiles/statusline-command.sh"
#  3. Run /statusline to setup

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# Shorten path to last two components (e.g. workspace/project)
short_cwd=$(echo "$cwd" | awk -F/ '{
  n = NF
  if (n >= 2) print $(n-1) "/" $n
  else print $0
}')

# Token counts and cost from actual JSON structure
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | awk '{printf "%.2f", $1}')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')

total_tokens=$((total_input + total_output))
total_tokens_k=$(awk -v t="$total_tokens" 'BEGIN { printf "%.2fk", t / 1000 }')

# Format duration as Xh Ym or Ym Xs
duration_s=$((duration_ms / 1000))
duration_h=$((duration_s / 3600))
duration_m=$(( (duration_s % 3600) / 60 ))
if [ "$duration_h" -gt 0 ]; then
  duration_str="${duration_h}h ${duration_m}m"
else
  duration_s_rem=$((duration_s % 60))
  duration_str="${duration_m}m ${duration_s_rem}s"
fi

# Build the left and right segments (plain text widths, no ANSI)
left_plain="📁 ${short_cwd}"
right_plain="🤖 ${model}  🪙 ${total_tokens_k}  💰 \$${cost}  ⏱️ ${duration_str}"

# Right-align: pad between left and right to fill terminal width
term_width=$(tput cols 2>/dev/null || echo 80)
# Each emoji (📁 🤖 🪙 💰 ⏱️) occupies 2 terminal columns but bash's ${#} counts them as 1 char each,
# subtract extra to account for double-width emoji characters + right padding.
pad_width=$((term_width - ${#left_plain} - ${#right_plain} - 4 - 11))
[ "$pad_width" -lt 1 ] && pad_width=1
padding=$(printf '%*s' "$pad_width" '')

printf "📁 \033[01;34m%s\033[00m" "$short_cwd"
printf "%s" "$padding"
printf "\033[00;33m%s\033[00m" "$right_plain"
