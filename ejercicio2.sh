#!/usr/bin/env bash
# grade_branch.shi
# Grades a Git branch from 0 to 100
# Usage: bash ejercico2.sh [branch] [base_branch]

BRANCH="${1:-$(git rev-parse --abbrev-ref HEAD)}"
BASE="${2:-main}"

SCORE=0
COMMITS=$(git log "${BASE}..${BRANCH}" --pretty=format:"%at %s" 2>/dev/null)
TOTAL=$(echo "$COMMITS" | grep -c . || true)
DIFF=$(git diff "${BASE}..${BRANCH}" 2>/dev/null)

echo "====================================="
echo " GRADING BRANCH: $BRANCH vs $BASE"
echo "====================================="

# ─── 1. COMMIT MESSAGES (40 pts) ─────────────────────────────────────────────
# Checks that each commit message:
#   - Starts with a type like feat:, fix:, docs:, etc.
#   - Is between 20 and 72 characters long
#   - Is written in English (mostly ASCII characters)
MSG_SCORE=0
if [ "$TOTAL" -gt 0 ]; then
  while read -r ts subject; do
    pts=0

    # +15 if commit follows Conventional Commits format (feat:, fix:, etc.)
    echo "$subject" | grep -qiE "^(feat|fix|chore|docs|style|refactor|test|perf|ci|build)(\(.+\))?:" && pts=$((pts+15))

    # +15 if subject length is between 20 and 72 characters
    len=${#subject}
    [ $len -ge 20 ] && [ $len -le 72 ] && pts=$((pts+15))

    # +10 if subject is in English (≥85% ASCII characters)
    ascii=$(echo "$subject" | tr -cd '[:print:]' | wc -c)
    total_c=$(echo -n "$subject" | wc -c)
    [ $total_c -gt 0 ] && ratio=$((ascii*100/total_c)) || ratio=0
    [ $ratio -ge 85 ] && pts=$((pts+10))

    MSG_SCORE=$((MSG_SCORE + pts))
  done <<< "$COMMITS"

  # Average across all commits, scaled to 40 pts max
  MSG_SCORE=$((MSG_SCORE / TOTAL))
  [ $MSG_SCORE -gt 40 ] && MSG_SCORE=40
fi

echo ""
echo "[1] Commit Messages: $MSG_SCORE / 40"

# ─── 2. COMMIT TIMING (30 pts) ───────────────────────────────────────────────
# Rewards commits made during working hours (07:00–20:00) on weekdays.
# Deducts 3 pts per off-hours commit and 3 pts per weekend commit.
TIMING_SCORE=30
if [ "$TOTAL" -gt 0 ]; then
  while read -r ts subject; do
    hour=$(date -d "@$ts" +%H 2>/dev/null || date -r "$ts" +%H)
    hour=$((10#$hour))
    dow=$(date -d "@$ts" +%u 2>/dev/null || date -r "$ts" +%u)
    dow=$((10#$dow))

    # Deduct 3 pts for commits outside 07:00–20:00
    [ $hour -lt 7 ] || [ $hour -ge 20 ] && TIMING_SCORE=$((TIMING_SCORE - 3))

    # Deduct 3 pts for commits on Saturday (6) or Sunday (7)
    [ $dow -ge 6 ] && TIMING_SCORE=$((TIMING_SCORE - 3))

    [ $TIMING_SCORE -lt 0 ] && TIMING_SCORE=0
  done <<< "$COMMITS"
fi

echo "[2] Commit Timing:   $TIMING_SCORE / 30"

# ─── 3. CODE COMMENTS (30 pts) ───────────────────────────────────────────────
# Analyzes added lines in the diff for comments (// # -- * ;).
# Awards points for:
#   - Density: at least 1 comment per 10 lines of code  (10 pts)
#   - English:  ≥80% of comments are ASCII-dominant     (10 pts)
#   - Quality:  comments average at least 5 words each  (10 pts)
COMMENT_SCORE=0
if [ -n "$DIFF" ]; then
  CODE_LINES=$(echo "$DIFF" | grep -E '^\+[^+]' | grep -v '^+++' | wc -l)
  COMMENT_LINES=$(echo "$DIFF" | grep -E '^\+[^+]' | grep -v '^+++' | grep -E '^\+\s*(//|#|--|/\*|\*|;)')
  COMMENT_COUNT=$(echo "$COMMENT_LINES" | grep -c . || true)

  # Density: 1 comment per 10 lines earns full 10 pts
  if [ "$CODE_LINES" -gt 0 ]; then
    TARGET=$((CODE_LINES / 10))
    [ $TARGET -lt 1 ] && TARGET=1
    if [ "$COMMENT_COUNT" -ge "$TARGET" ]; then
      COMMENT_SCORE=$((COMMENT_SCORE + 10))
    else
      COMMENT_SCORE=$((COMMENT_SCORE + COMMENT_COUNT * 10 / TARGET))
    fi
  fi

  # English: count how many comments are ≥80% ASCII
  if [ "$COMMENT_COUNT" -gt 0 ]; then
    ENG=0
    while IFS= read -r line; do
      text=$(echo "$line" | sed 's/^+//' | sed 's|^\s*\(//\|#\|--\|/\*\|\*\|;\)||')
      a=$(echo "$text" | tr -cd '[:print:]' | wc -c)
      t=$(echo -n "$text" | wc -c)
      [ $t -gt 0 ] && r=$((a*100/t)) || r=0
      [ $r -ge 80 ] && ENG=$((ENG+1))
    done <<< "$COMMENT_LINES"
    COMMENT_SCORE=$((COMMENT_SCORE + ENG * 10 / COMMENT_COUNT))
  fi

  # Quality: average comment length ≥ 5 words earns 10 pts
  if [ "$COMMENT_COUNT" -gt 0 ]; then
    WORDS=0
    while IFS= read -r line; do
      text=$(echo "$line" | sed 's/^+//' | sed 's|^\s*\(//\|#\|--\|/\*\|\*\|;\)||')
      w=$(echo "$text" | wc -w)
      WORDS=$((WORDS + w))
    done <<< "$COMMENT_LINES"
    AVG=$((WORDS / COMMENT_COUNT))
    [ $AVG -ge 5 ] && COMMENT_SCORE=$((COMMENT_SCORE + 10)) || \
    [ $AVG -ge 3 ] && COMMENT_SCORE=$((COMMENT_SCORE + 5))
  fi
fi

[ $COMMENT_SCORE -gt 30 ] && COMMENT_SCORE=30
echo "[3] Code Comments:   $COMMENT_SCORE / 30"

# ─── TOTAL ────────────────────────────────────────────────────────────────────
TOTAL_SCORE=$((MSG_SCORE + TIMING_SCORE + COMMENT_SCORE))
[ $TOTAL_SCORE -gt 100 ] && TOTAL_SCORE=100

echo ""
echo "====================================="
echo " TOTAL SCORE: $TOTAL_SCORE / 100"
[ $TOTAL_SCORE -ge 85 ] && echo " Grade: Excellent"
[ $TOTAL_SCORE -ge 70 ] && [ $TOTAL_SCORE -lt 85 ] && echo " Grade: Good"
[ $TOTAL_SCORE -ge 50 ] && [ $TOTAL_SCORE -lt 70 ] && echo " Grade: Fair"
[ $TOTAL_SCORE -lt 50 ] && echo " Grade: Needs work"
echo "====================================="
