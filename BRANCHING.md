# Branching

**Air Apps** use a system close to (but not exactly like) GitFlow. It differs only in the release phase, which is managed by the company Code Owners. So, from a contributing perspective it can be considered GitFlow.
These are types of branches we use and each has a convention for its name.

- ``master``: it stores the official release history.
- ``develop``: it serves as an integration branch for features.
- ``feature``: to implement app features, add this prefix on the branch name (example: ``feature/Home``).
- ``bugfix``: to fix some issues that may occur in the process, add this prefix on the branch name (example: ``bugfix/FixHomeMemoryIssue``)
- ``hotfix``: to fix some issues that may occur as priority/critical in a production environment, add this prefix on the branch name (example: hotfix/FixCriticialIssue)

Ensure branch base folders (e,g, `feature`) have the correct casing and that branch names use camel casing where appropriate. Dashes/hypens are allowed.

- `bugfix/issue-XXX-fixHomeMemoryIssue` ✅
- `bugfix/issue-XXX-fixhomememoryissue` ❌
- `bugfixs/FixHomeIssue` ❌
- `bugFix/FixHomeIssue` ❌