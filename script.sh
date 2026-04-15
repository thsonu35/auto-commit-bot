#!/bin/bash

MIN_COMMITS=4
MAX_COMMITS=8

# Decide if today is commit day
RANDOM_DAY=$((RANDOM % 7))

if [ $RANDOM_DAY -gt 4 ]; then
  echo "Skipping today"
  exit 0
fi

# Number of commits
COMMITS=$(( RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS ))

echo "Total commits today: $COMMITS"

# Words for dynamic messages
TYPES=("fix" "feat" "refactor" "update" "style" "docs" "perf" "chore" "test")
SCOPES=("auth" "api" "ui" "dashboard" "login" "payment" "profile" "db" "config")
ACTIONS=("improve" "fix" "add" "remove" "update" "optimize" "clean" "refactor")
TARGETS=("logic" "validation" "bug" "flow" "design" "performance" "structure")

# Start time (9–11 AM)
START_HOUR=$(( (RANDOM % 3) + 9 ))
START_MIN=$(( RANDOM % 60 ))

CURRENT_TIME=$(date -d "today $START_HOUR:$START_MIN" +"%Y-%m-%d %H:%M:%S")

for ((i=1; i<=COMMITS; i++))
do
  TYPE=${TYPES[$RANDOM % ${#TYPES[@]}]}
  SCOPE=${SCOPES[$RANDOM % ${#SCOPES[@]}]}
  ACTION=${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}
  TARGET=${TARGETS[$RANDOM % ${#TARGETS[@]}]}
  ISSUE=$((RANDOM % 200))

  # Final dynamic message
  MSG="$TYPE($SCOPE): $ACTION $TARGET #$ISSUE"

  # Change file
  echo "Update $i at $CURRENT_TIME" >> data.txt

  git add data.txt

  # Commit
  GIT_COMMITTER_DATE="$CURRENT_TIME" git commit --date="$CURRENT_TIME" -m "$MSG"

  echo "Committed: $MSG at $CURRENT_TIME"

  # Gap (1–2 hr + random minutes)
  GAP_HOUR=$(( (RANDOM % 2) + 1 ))
  GAP_MIN=$(( RANDOM % 60 ))

  CURRENT_TIME=$(date -d "$CURRENT_TIME +$GAP_HOUR hour +$GAP_MIN min" +"%Y-%m-%d %H:%M:%S")

  sleep 1
done
