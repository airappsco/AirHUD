# Commits
Commits help other people to understand what some piece of code does. If someone else on the project team will continue your task, or help to finish it, or even if someone is reviewing the Pull Request, to look at commit messages may give a clue of the progress is done in the branch.

To write better commit messages, it is necessary to follow some guidelines:

## Make small commits!

If you are working on a `feature` or a `bugfix`, each step or feature progress should produce a separate commit. By doing that you are creating an organized log of commits, which makes it easy for other developers to read and maintain the codebase. It also avoids the commit of large chunks of code and it is easier to glance through the commit history.

## Commit complete and well-tested code

Never commit incomplete code. This goes against the concept of committing. If you are working on a large task, try to break it down to smaller assignments and ensure that each task is complete.

## Style

The most important part of a commit message is that it should be clear and meaningful.

Use the imperative tense, because it represents the purpose of the code at this specific commit and it sounds like an instruction or command. A properly formed Git commit subject line should always be able to complete the following sentence: If applied, this commit will (…):

For example, use:
- “Fix issue from Home's tableView" ✅
- “Fixing issue from Home's tableView” ❌.

> Do not end the subject line with a period.

Do not assume the reviewer understands what the original problem was, ensure you add it, and don't think your code is self-explanatory.