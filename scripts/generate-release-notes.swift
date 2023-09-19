//
//  ExampleApp.swift
//  Example
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright © 2023 AirApps. All rights reserved.
//
import Foundation

let arguments = CommandLine.arguments

// First argument is the git log
let mergeHistory = arguments.count > 1 ? arguments[1] : ""

// Second argument is the an additional release description
let releaseDescription = arguments.count > 2 ? arguments[2] : ""

// Third argument is the format of the generated release notes (check ReleaseNotesFormat enum)
let rawReleaseNotesFormat = arguments.count > 3 ? arguments[3] : ""

enum Constants {
    // Jira base URL used for making Jira ticket links
    static let jiraBaseUrl = "https://airappsco.atlassian.net/browse"

    // Github PR base URL used for making PR links
    static let githubPullRequestBaseUrl = "https://github.com/airappsco/AirHUD/pull"
}

// Possible output formats
enum ReleaseNotesFormat: String {
    case github
    case appStoreConnect
}

// Utility builder class for producing markdown output
final class Markdown {
    private var text = ""

    var isEmpty: Bool {
        make().isEmpty
    }

    private func append(text: String) -> Markdown {
        self.text.append("\n\(text)")
        return self
    }

    @discardableResult
    func title3(text: String) -> Markdown {
        append(text: "### \(text)")
    }

    @discardableResult
    func text(text: String) -> Markdown {
        append(text: text)
    }

    @discardableResult
    func bullet(text: String) -> Markdown {
        append(text: "* \(text)")
    }

    @discardableResult
    func bulletLink(text: String, url: String) -> Markdown {
        append(text: "* [\(text)](\(url))")
    }

    @discardableResult
    func lineBreak() -> Markdown {
        append(text: "")
    }

    @discardableResult
    func markdown(_ markdown: Markdown) -> Markdown {
        append(text: markdown.make())
    }

    func make() -> String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct Commit {
    let title: String
    let body: String?

    var jiraTickets: [String] {
        guard let body = body else {
            return []
        }

        let range = NSRange(body.startIndex ..< body.endIndex, in: body)
        // Matches Jira code at the beggining, e.g. TN-213: Something
        let regexString = "([A-Z]+-[0-9]+ *)+"
        guard let regex = try? NSRegularExpression(pattern: regexString),
              let match = regex.firstMatch(in: body, options: [], range: range),
              let matchRange = Range(match.range, in: body) else {
            return []
        }

        return body[matchRange]
            // There could be more than one ticket linked, e.g. TN-213 TN-265: Something
            .components(separatedBy: .whitespaces)
            .map { "\(Constants.jiraBaseUrl)/\($0)" }
    }

    var pullRequestId: String? {
        let mergeText = "Merge pull request #"
        let range = NSRange(title.startIndex ..< title.endIndex, in: title)

        guard let regex = try? NSRegularExpression(pattern: "\(mergeText)[0-9]+"),
              let match = regex.firstMatch(in: title, options: [], range: range),
              let matchRange = Range(match.range, in: title) else {
            return nil
        }

        let lowerBound = title.index(matchRange.lowerBound, offsetBy: mergeText.count)
        return String(title[lowerBound ..< matchRange.upperBound])
    }

    var pullRequestUrl: String? {
        guard let pullRequestId = pullRequestId else {
            return nil
        }
        return "\(Constants.githubPullRequestBaseUrl)/\(pullRequestId)"
    }

    var sanitizedBody: String? {
        guard let body = body else {
            return nil
        }

        guard let index = body.firstIndex(of: ":") else {
            return body
        }

        let startIndex = body.index(index, offsetBy: 1)
        return String(body[startIndex ..< body.endIndex])
            .trimmingCharacters(in: .whitespaces)
    }
}

final class ReleaseNotesGenerator {
    func generateReleaseNotes(format: ReleaseNotesFormat) {
        switch format {
        case .github:
            generateGithubReleaseNotes()
        case .appStoreConnect:
            generateAppStoreConnectReleaseNotes()
        }
    }

    private func readCommitHistory() -> [Commit] {
        mergeHistory
            // ---------- is the separator between each merge commit entry
            .components(separatedBy: "----------")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            // Filter: only pull request merges
            .filter {
                let isPullRequest = $0.contains("Merge pull request #")
                return isPullRequest
            }
            // Break by line break and create commit
            .compactMap { entry -> Commit? in
                let components = entry.components(separatedBy: .newlines)
                guard components.count > 1 else {
                    return Commit(title: entry, body: nil)
                }
                return Commit(title: components[0], body: components[1])
            }
    }

    private func generateGithubReleaseNotes() {
        let commits = readCommitHistory()

        // Collect Pull Requests urls
        let pullRequests = commits.reduce(Markdown()) { markdown, commit -> Markdown in
            guard let pullRequestId = commit.pullRequestId, let pullRequestUrl = commit.pullRequestUrl else {
                if let body = commit.sanitizedBody {
                    return markdown.bullet(text: body)
                }
                return markdown
            }

            guard let body = commit.sanitizedBody else {
                return markdown.bulletLink(text: "#\(pullRequestId)", url: pullRequestUrl)
            }

            return markdown.bulletLink(text: "#\(pullRequestId) - \(body)", url: pullRequestUrl)
        }
        if pullRequests.isEmpty {
            pullRequests.text(text: "No Pull Requests found")
        }

        // Collect Jira tickets urls
        let jiraTickets = commits.reduce(Markdown()) { markdown, commit -> Markdown in
            commit.jiraTickets.forEach { ticket in
                markdown.bulletLink(text: ticket, url: ticket)
            }
            return markdown
        }
        if jiraTickets.isEmpty {
            jiraTickets.text(text: "No tickets found")
        }

        let releaseNotes = Markdown()

        if !releaseDescription.isEmpty {
            releaseNotes
                .title3(text: "Description")
                .text(text: releaseDescription)
                .lineBreak()
        }

        releaseNotes
            .title3(text: "Pull Requests")
            .markdown(pullRequests)
            .lineBreak()
            .title3(text: "Jira Tickets")
            .markdown(jiraTickets)

        // Ouputs to terminal
        print(releaseNotes.make())
    }

    private func generateAppStoreConnectReleaseNotes() {
        let commits = readCommitHistory()
        let releaseNotes = commits.reduce(Markdown()) { markdown, commit -> Markdown in
            guard let body = commit.sanitizedBody ?? commit.body else {
                return markdown
            }
            return markdown.text(text: "- \(body)")
        }
        let notes = releaseNotes.make()
        guard !notes.isEmpty else {
            return print("Minor issues fixed")
        }

        return print(notes)
    }
}

guard let format = ReleaseNotesFormat(rawValue: rawReleaseNotesFormat) else {
    print("Invalid release notes format")
    exit(1)
}

let generator = ReleaseNotesGenerator()
generator.generateReleaseNotes(format: format)
