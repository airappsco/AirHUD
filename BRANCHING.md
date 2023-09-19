# 🌳 Branching

**Air Apps** uses a branching strategy similar to GitFlow, with slight variations tailored to our release phase managed by our Code Owners. For contributors, it can be largely seen as GitFlow. Here's a breakdown of the branch types and naming conventions:

- `master`: 📜 It stores the official release history.
- `develop`: 🔄 This serves as an integration branch for features.
- `feature`: ⭐ For implementing app features. Ensure to add this prefix to the branch name, for instance, `feature/Home`.
- `bugfix`: 🐛 When addressing issues during the development process, use this prefix, e.g., `bugfix/FixHomeMemoryIssue`.
- `hotfix`: 🔥 For critical or priority issues in a production environment, use this naming convention: `hotfix/FixCriticalIssue`.

### 📝 Naming Conventions

It's crucial to adhere to the naming standards, especially concerning casing and format:

- Branch base folders (e.g., `feature`) should have the right casing.
- Branch names should use camel casing where relevant. Dashes/hyphens are acceptable.
  
  Examples:
  - `bugfix/issue-XXX-fixHomeMemoryIssue` ✅
  - `bugfix/issue-XXX-fixhomememoryissue` ❌
  - `bugfixs/FixHomeIssue` ❌
  - `bugFix/FixHomeIssue` ❌

This helps maintain clarity and consistency in our codebase, ensuring a smooth workflow for all contributors.
