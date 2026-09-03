# Branch protection recommended steps

Recommended branch protection for 'main':

- Require pull requests before merging (prevent direct pushes)
- Require status checks to pass (select the CI workflow: "CI")
- Require at least 1 approving review
- Dismiss stale pull request approvals when new commits are pushed
- Require signed commits (optional)

How to enable (via GitHub web UI):
1. Go to your repository on GitHub -> Settings -> Branches -> Branch protection rules.
2. Click "Add rule".
3. In "Branch name pattern" enter: main
4. Select:
   - "Require a pull request before merging"
   - "Require status checks to pass before merging" and choose the check named "CI"
   - "Require approvals" and set "Require x approvals" to 1
   - "Dismiss stale pull request approvals when new commits are pushed"
5. Click "Create".

Note: If you want me to attempt to apply these rules via API, grant me repository admin permissions or perform the steps above and I can verify.
