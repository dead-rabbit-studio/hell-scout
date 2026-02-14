---
name: create-pr
description: Create a pull request for the current branch
disable-model-invocation: true
argument-hint: [base-branch]
---

Create a pull request from the current branch. Base branch defaults to `main` unless specified.

Base: $ARGUMENTS

## Steps

1. Run `git status` and `git diff main...HEAD` to understand all changes
2. Check `git log main..HEAD --oneline` for ALL commits on this branch — the PR covers every commit, not just the latest
3. Push the branch to remote if needed (`git push -u origin <branch>`)
4. Write the PR:
   - **Title**: short, under 70 chars, lowercase, no period. Use conventional prefix (feat:, fix:, docs:, refactor:, test:, chore:)
   - **Summary**: 2-5 bullet points covering what changed and why. Be specific — mention file names and behaviors, not vague descriptions
   - **Test plan**: concrete checklist of what to verify
5. Create with `gh pr create`

## Format

```
gh pr create --title "prefix: short description" --body "$(cat <<'EOF'
## Summary
- bullet points here

## Test plan
- [ ] concrete steps

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

## Rules
- Read the actual diffs. Don't guess what changed from commit messages alone.
- Don't pad the summary with obvious things. "Updated files" is not useful.
- If there are known gotchas or things reviewers should watch for, mention them.
