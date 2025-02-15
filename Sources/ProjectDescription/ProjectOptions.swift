import Foundation

extension Project {
    /// Additional options related to the `Project`
    public struct Options: Codable, Equatable {
        /// Defines how to generate automatic schemes
        public let automaticSchemesOptions: AutomaticSchemesOptions

        /// Tuist generates the project with the specific development region.
        public let developmentRegion: String?

        /// Disables generating Bundle accessors.
        public let disableBundleAccessors: Bool

        /// Tuist disables echoing the ENV in shell script build phases
        public let disableShowEnvironmentVarsInScriptPhases: Bool

        /// Disable the synthesized resource accessors generation
        public let disableSynthesizedResourceAccessors: Bool

        /// Text settings to override user ones for current project
        public let textSettings: TextSettings

        /// Tuist generates the project with the specific name on disk instead of using the project name.
        public let xcodeProjectName: String?

        public static func options(
            automaticSchemesOptions: AutomaticSchemesOptions = .enabled(),
            developmentRegion: String? = nil,
            disableBundleAccessors: Bool = false,
            disableShowEnvironmentVarsInScriptPhases: Bool = false,
            disableSynthesizedResourceAccessors: Bool = false,
            textSettings: TextSettings = .textSettings(),
            xcodeProjectName: String? = nil
        ) -> Self {
            self.init(
                automaticSchemesOptions: automaticSchemesOptions,
                developmentRegion: developmentRegion,
                disableBundleAccessors: disableBundleAccessors,
                disableShowEnvironmentVarsInScriptPhases: disableShowEnvironmentVarsInScriptPhases,
                disableSynthesizedResourceAccessors: disableSynthesizedResourceAccessors,
                textSettings: textSettings,
                xcodeProjectName: xcodeProjectName
            )
        }
    }
}

// MARK: - AutomaticSchemesOptions

extension Project.Options {
    /// The automatic schemes options
    public enum AutomaticSchemesOptions: Codable, Equatable {
        /// Defines how to group targets into scheme for autogenerated schemes
        public enum TargetSchemesGrouping: Codable, Equatable {
            /// Generate a single scheme for the whole project
            case singleScheme

            /// Group the targets according to their name suffixes
            case byNameSuffix(build: Set<String>, test: Set<String>, run: Set<String>)

            /// Do not group targets, create a scheme for each target
            case notGrouped
        }

        /// Enable autogenerated schemes
        case enabled(
            targetSchemesGrouping: TargetSchemesGrouping = .byNameSuffix(
                build: ["Implementation", "Interface", "Mocks", "Testing"],
                test: ["Tests", "IntegrationTests", "UITests", "SnapshotTests"],
                run: ["App", "Demo"]
            ),
            codeCoverageEnabled: Bool = false,
            testingOptions: TestingOptions = []
        )

        /// Disable autogenerated schemes
        case disabled
    }

    /// The text settings options
    public struct TextSettings: Codable, Equatable {
        /// Whether tabs should be used instead of spaces
        public let usesTabs: Bool?

        /// The width of space indent
        public let indentWidth: UInt?

        /// The width of tab indent
        public let tabWidth: UInt?

        /// Whether lines should be wrapped or not
        public let wrapsLines: Bool?

        public static func textSettings(
            usesTabs: Bool? = nil,
            indentWidth: UInt? = nil,
            tabWidth: UInt? = nil,
            wrapsLines: Bool? = nil
        ) -> Self {
            self.init(usesTabs: usesTabs, indentWidth: indentWidth, tabWidth: tabWidth, wrapsLines: wrapsLines)
        }
    }
}
