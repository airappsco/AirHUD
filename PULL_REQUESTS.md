# Pull Request Process
This document describes the key activities and guidelines related to Pull Requests (PR) that we should follow. It's a set of best practices well known in the mobile software development world, adapted to our resources and ways of working. We aim to reach these goals:

- Build a clean, well-architected, high-quality codebase.
- Foster collaboration and ownership by sharing responsibilities.
- Incrementally build coding standards (e.g. naming, architecture, code styling).
- Make code reviewing faster, fun, and less prone to introducing regressions
- Increase the overall confidence in the codebase.

Naturally, this is a collaborative and incremental process. This means that mostly anything is open to change and we’ll improve the process as we implement it. We encourage you to drop your feedback at any time to make this happen.

## Key Activities
Make sure to follow branch naming guidelines. Please refer to [this](./BRANCHING.md) document for further guidance.

Follow the commit message guidelines. You can find the standards in [this](./COMMITS.md) document.

Fill out the PR template. There is a default message which is automatically added for every PR. Please do not delete it and try to add as much context as possible.

Link a Jira ticket or GitHub issue to the PR. This keeps things organized and trackable by product and engineering. Ideally, we should not start working on tasks that don't have a ticket.

At least 2 approvals are required to merge PRs. These approvals needs to be from a **Code Owner** of the repository.

All checks must pass before a PR can be merged.

For private branches (e.g. bugfix, feature branches), prefer rebasing over merging to integrate the changes from develop. The reason is to avoid unnecessary pollution and un-linearization of commit history in branches that are usually short-lived (ideally, PRs should be small).

To keep the repository clean and organised, merged branches will be automatically deleted.

As a reviewer, you don't need to pull down branches to test the changes, unless you feel it's necessary. Rule of thumb: it is the responsibility of the PR’s author to provide as much context as necessary to show how their changes impact the codebase and the product.


## Guidelines

Be clear and descriptive

Please, don't.

INSERT IMAGE HERE



Put yourself in the shoes of the reviewers. Keep in mind that the codebase is shared and provide as much detail as you can so reviewers are able to understand your rationale and how the changes are connected, to a point where reviewers can not only comment on isolated lines but also provide insightful ideas on the overall logic. Some tips:
- Add screenshots if you're introducing UI changes. This is not only a way to catch issues early, but also contextualizes reviewers and documents UI changes over time. If what you're doing has different states that are worth testing, don't shy away and add as many screenshots as you think can help. If you can do screen recordings that's even better! We encourage the usage of tools such as QuickTime for video recording and Giphy for GIF recording.
- Explain engineering decisions. Usually, the linked ticket will contain a high-level description from a product perspective. Reviewers can go to that ticket to get some context, but it's the responsibility of the engineers to also surface any background context that supports coding decisions.
- Guide the reviewers. Say, for instance, which is the best file to start reviewing or add comments to important parts. If the PR is easy to review, it usually gets merged faster.
- Expand your audience. A well-described PR can sometimes even be reviewed by non-developers. For instance, you can provide such a screenshot with information that designers can also be added as reviewers.

## Keep PRs small
Avoid creating huge PRs that introduce too many code changes. Keeping them small helps reviewers to understand them faster and the overall review process is sped up. Small PRs can also help in ensuring quality, as reviewers can suggest improvements in the basic building blocks rather than getting entangled in an overly complex code.

## Avoid changing more than necessary
Please try to keep your PR focused on what is intended for. Don't let it get out of scope. Commits and PRs tell the history of the codebase and adding unnecessary or unintended code makes that history confusing and hard to understand the reasoning behind the changes. Even harmless unnecessary changes should be avoided in order to keep the code as clean as possible.

## Address review comments
The code review process is fundamentally collaborative. The code you're trying to integrate will eventually be owned by all team members and everyone has to agree upon what's being developed. Naturally, we can't agree on everything, but we can (and should) discuss to implement better solutions. Ignoring comments is not only impolite but also leads to longer review times and can compromise quality.

## Don't shortcut
Don't shortcut your work because you want to be praised for being fast. Be praised for building it right. It's normal that the code review process takes a little longer, as we're seeking for quality.

## References
https://www.atlassian.com/blog/git/written-unwritten-guide-pull-requests

https://holgerfrohloff.de/best-practices-on-doing-pull-requests/

https://github.community/t/best-practices-for-pull-requests/10195

https://seesparkbox.com/foundry/github_pull_requests_for_everyone