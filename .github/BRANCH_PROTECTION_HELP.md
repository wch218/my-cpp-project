## How to apply branch protection locally using gh CLI

If you prefer to run a one-off command locally (requires gh CLI and that you're an admin on the repo):

1. Install GitHub CLI and authenticate:
   gh auth login

2. Run the following command to create a branch protection rule for main:

   gh api --method PUT -H "Accept: application/vnd.github+json" /repos/:owner/:repo/branches/main/protection -f required_status_checks='{"strict":true,"contexts":["CI"]}' -f enforce_admins=true -f required_pull_request_reviews='{"dismiss_stale_reviews":true,"required_approving_review_count":1}'

Replace `:owner` and `:repo` with your values (or run inside the cloned repo and use $(jq -r .repository.owner.login < .git/config) style substitutions).
