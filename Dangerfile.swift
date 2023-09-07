import Danger
let danger = Danger()

let arguments = CommandLine.arguments

// Check if at least one argument (XCResult path) is provided
if arguments.count < 2 {
    fail("Please provide the path to the .xcresult file as the first argument.")
    exit(1)
}

// The first argument is the path to the .xcresult file
let xcresultPath = arguments[1]

// Code coverage gate
let minimumCoverageThreshold: Double = 50.0

// Use xcparse to extract code coverage information from the .xcresult file
let coverageCommand = "xcparse coverage --file \(xcresultPath)"
if let coverageOutput = danger.shell(coverageCommand).stdout {
    if let coverage = Double(coverageOutput) {
        if coverage < minimumCoverageThreshold {
            warn("Code coverage is below \(minimumCoverageThreshold)%")
            fail("Code coverage must be at least \(minimumCoverageThreshold)%")
        }
        // success path
    } else {
        fail("Failed to parse code coverage data from \(xcresultPath)")
    }
} else {
    fail("Failed to run \(coverageCommand)")
}



// Pull request size
let bigPRThreshold = 500
let additions = danger.github.pullRequest.additions ?? 0
let deletions = danger.github.pullRequest.deletions ?? 0
let changedFiles = danger.github.pullRequest.changedFiles ?? 0

// Pull request size validation
if (additions + deletions) > bigPRThreshold {
    message("⚠️⚠️ PR size seems relatively large. ✂️ If this PR contains multiple changes, please split each into separate PR will helps faster, easier review.")
}

// Pull request body validation
if danger.github.pullRequest.body == nil || danger.github.pullRequest.body?.isEmpty ?? true {
    warn("⚠️⚠️ This PR has no description. 📝 You should provide a description of the changes that have made.")
}

// Pull request title validation
let prTitle = danger.github.pullRequest.title
if prTitle.count < 5 {
    warn("⚠️⚠️ PR title is too short. 🙏 Please use this format `IOSDEV-000: Your feature title` and replace `000` with Jira task number.")
}

// IOSDEV- current prefix for our iOS development board on Jira
if !prTitle.contains("IOSDEV-") {
    warn("⚠️⚠️ PR title does not containe the related Jira task. 🙏 Please use this format `IOSDEV-000: Your feature title` and replace `000` with Jira task number.")
}

// Files changed and created should includes unit tests
let modified = danger.git.modifiedFiles
let editedFiles = modified + danger.git.createdFiles
let testFiles = editedFiles.filter { ($0.contains("Tests") || $0.contains("Test")) && $0.fileType == .swift }

if testFiles.isEmpty {
    message("⚠️⚠️ This PR does not contain any files related to unit tests 🧪🧪 (ignore if your changes do not require tests)")
}

message("🎉🎉 The PR added \(additions) and removed \(deletions) lines. 🗂 \(changedFiles) files changed. Great Job!")

/*
 Commenting the following because the rules in swiftlint.yml was not picking up

Things to take care of when you uncomment
 1. Add the Swiftlint script in Build Phases for fontbot.
         The script should be
         "${PODS_ROOT}/SwiftLint/swiftlint"
 2. Build and see if the rules in swiftlint.yml is reflecting in the warnings showing up
 3. There are some force casts/errors in legacy code. Test whenever you make a change.

// In case your project is cotained in a root folder include the directory.
SwiftLint.lint(
    .modifiedAndCreatedFiles(directory: "fontbot"),
    configFile: "fontbot/.swiftlint.yml",
    swiftlintPath: SwiftLint.SwiftlintPath.bin("fontbot/Pods/SwiftLint/swiftlint")
)
*/
