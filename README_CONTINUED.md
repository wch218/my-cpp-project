## Publish devcontainer image

This repository includes a GitHub Actions workflow to build and publish a devcontainer image to GitHub Container Registry (GHCR): `.github/workflows/publish-devcontainer.yml`.

To enable publishing automatically from Actions:
1. Ensure Actions has permission to create and publish packages. In repository Settings -> Actions -> General -> Workflow permissions, allow `Read and write permissions` for the GITHUB_TOKEN and enable `Allow GitHub Actions to create and approve pull requests` if needed.
2. The workflow uses `secrets.GITHUB_TOKEN` automatically (no additional secret needed) to push to `ghcr.io/${{ github.repository_owner }}`. For organization-level publish or more control, you can create a PAT with `write:packages` and store it in `GHCR_PAT` secret and update the workflow to use it.

After a successful run you will find the image tagged as:
- ghcr.io/<your-gh-username>/my-cpp-project/devcontainer:latest
- ghcr.io/<your-gh-username>/my-cpp-project/devcontainer:<commit-sha>

## Branch protection automation

A workflow `.github/workflows/protect-branch.yml` is provided to apply branch protection via REST API when executed via workflow_dispatch. For security, it requires a secret `ADMIN_TOKEN` (a personal access token with `repo` and `admin:repo_hook` permissions) to be added to the repository secrets.

Alternatively, you can enable branch protection via the GitHub web UI: Repository -> Settings -> Branches -> Add rule (pattern `main`) and enable the recommended options: require PRs, require status checks (CI), require 1 review, dismiss stale approvals.

## Coverage upload

The `.github/workflows/coverage.yml` workflow runs coverage on push/pull_request and uploads `coverage.info` as an artifact. To upload coverage to Codecov automatically, add a `CODECOV_TOKEN` secret to the repository secrets. For public repositories Codecov may accept uploads without a token; if not, add the token.
