#!/bin/bash

# --- CONFIG ---
MIN_COMMITS=4
MAX_COMMITS=8

# --- Decide if today is commit day (approx 4–7 days/week) ---
RANDOM_DAY=$((RANDOM % 7))

if [ $RANDOM_DAY -gt 4 ]; then
  echo "Skipping today"
  exit 0
fi

# --- Number of commits today ---
COMMITS=$(( RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS ))

echo "Total commits today: $COMMITS"

# --- Random commit messages ---
MESSAGES=(
  "fix: minor bug fix"
  "feat: added new feature"
  "update: improved logic"
  "refactor: cleaned code"
  "docs: updated readme"
  "style: formatting changes"
  "perf: improved performance"
  "chore: small update"
  "test: added test cases"
  "fix: issue #$((RANDOM % 100))"
  "feat: UI improvement"
  "refactor: optimized code"
)

# --- Start time (random between 9 AM to 12 PM) ---
START_HOUR=$(( (RANDOM % 4) + 9 ))
CURRENT_TIME=$(date -d "today $START_HOUR:00" +"%Y-%m-%d %H:%M:%S")

for ((i=1; i<=COMMITS; i++))
do
  # Pick random message
  MSG=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}

  # Make file change
  echo "Update $i at $CURRENT_TIME" >> data.txt

  git add data.txt

  # Commit with fake time
  GIT_COMMITTER_DATE="$CURRENT_TIME" git commit --date="$CURRENT_TIME" -m "$MSG"

  echo "Committed: $MSG at $CURRENT_TIME"

  # Add random gap (1–2 hours)
  GAP=$(( (RANDOM % 2) + 1 ))
  CURRENT_TIME=$(date -d "$CURRENT_TIME +$GAP hour" +"%Y-%m-%d %H:%M:%S")

  sleep 1
done
