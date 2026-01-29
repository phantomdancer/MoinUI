import SwiftUI
import MoinUI

struct TimelineExamples: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "timeline.basic"),
        AnchorItem(id: "color", titleKey: "timeline.color"),
        AnchorItem(id: "pending", titleKey: "timeline.pending"),
        AnchorItem(id: "alternate", titleKey: "timeline.alternate"),
        AnchorItem(id: "custom", titleKey: "timeline.custom"),
        AnchorItem(id: "right", titleKey: "timeline.right"),
        AnchorItem(id: "label", titleKey: "timeline.label")
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Timeline", anchors: anchors) { _ in
            basicExample.id("basic")
            colorExample.id("color")
            pendingExample.id("pending")
            alternateExample.id("alternate")
            customExample.id("custom")
            rightExample.id("right")
            labelExample.id("label")
        }
    }

    // MARK: - Basic

    private var basicExample: some View {
        ExampleSection(
            title: tr("timeline.basic"),
            description: tr("timeline.basic_desc")
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("timeline.demo.create_project"))
                Moin.Timeline.Item(tr("timeline.demo.solve_issues"))
                Moin.Timeline.Item(tr("timeline.demo.tech_review"))
                Moin.Timeline.Item(tr("timeline.demo.deploy"))
            }
        } code: {
            """
            Moin.Timeline {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item("\(tr("timeline.demo.solve_issues"))")
                Moin.Timeline.Item("\(tr("timeline.demo.tech_review"))")
                Moin.Timeline.Item("\(tr("timeline.demo.deploy"))")
            }
            """
        }
    }

    // MARK: - Color

    private var colorExample: some View {
        ExampleSection(
            title: tr("timeline.color"),
            description: tr("timeline.color_desc")
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("timeline.demo.create_success"), color: .green)
                Moin.Timeline.Item(tr("timeline.demo.in_progress"), color: .blue)
                Moin.Timeline.Item(tr("timeline.demo.completed"), color: .gray)
                Moin.Timeline.Item(tr("timeline.demo.error_occurred"), color: .red)
            }
        } code: {
            """
            Moin.Timeline {
                Moin.Timeline.Item("\(tr("timeline.demo.create_success"))", color: .green)
                Moin.Timeline.Item("\(tr("timeline.demo.in_progress"))", color: .blue)
                Moin.Timeline.Item("\(tr("timeline.demo.completed"))", color: .gray)
                Moin.Timeline.Item("\(tr("timeline.demo.error_occurred"))", color: .red)
            }
            """
        }
    }

    // MARK: - Pending

    private var pendingExample: some View {
        ExampleSection(
            title: tr("timeline.pending"),
            description: tr("timeline.pending_desc")
        ) {
            HStack(alignment: .top, spacing: 40) {
                VStack(alignment: .leading) {
                    Text("pending: true")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Moin.Timeline(pending: true) {
                        Moin.Timeline.Item(tr("timeline.demo.create_project"))
                        Moin.Timeline.Item(tr("timeline.demo.solve_issues"))
                        Moin.Timeline.Item(tr("timeline.demo.tech_review"))
                    }
                }

                VStack(alignment: .leading) {
                    Text("reverse: true")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Moin.Timeline(reverse: true) {
                        Moin.Timeline.Item(tr("timeline.demo.create_project"))
                        Moin.Timeline.Item(tr("timeline.demo.solve_issues"))
                        Moin.Timeline.Item(tr("timeline.demo.tech_review"))
                    }
                }
            }
        } code: {
            """
            // pending: true
            Moin.Timeline(pending: true) {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item("\(tr("timeline.demo.solve_issues"))")
                Moin.Timeline.Item("\(tr("timeline.demo.tech_review"))")
            }

            // reverse: true
            Moin.Timeline(reverse: true) {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item("\(tr("timeline.demo.solve_issues"))")
                Moin.Timeline.Item("\(tr("timeline.demo.tech_review"))")
            }
            """
        }
    }

    // MARK: - Alternate

    private var alternateExample: some View {
        ExampleSection(
            title: tr("timeline.alternate"),
            description: tr("timeline.alternate_desc")
        ) {
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(tr("timeline.demo.create_project"))
                Moin.Timeline.Item(tr("timeline.demo.solve_issues"), color: .green)
                Moin.Timeline.Item { Text(tr("timeline.demo.tech_review")) }
                Moin.Timeline.Item(tr("timeline.demo.deploy"), color: .red)
            }
        } code: {
            """
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item("\(tr("timeline.demo.solve_issues"))", color: .green)
                Moin.Timeline.Item { Text("\(tr("timeline.demo.tech_review"))") }
                Moin.Timeline.Item("\(tr("timeline.demo.deploy"))", color: .red)
            }
            """
        }
    }

    // MARK: - Custom

    private var customExample: some View {
        ExampleSection(
            title: tr("timeline.custom"),
            description: tr("timeline.custom_desc")
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("timeline.demo.create_project"))
                Moin.Timeline.Item(color: .green, dot: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }) {
                    Text(tr("timeline.demo.solve_issues"))
                }
                Moin.Timeline.Item(dot: {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.orange)
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tr("timeline.demo.tech_review"))
                        Text(tr("timeline.demo.tech_time"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Moin.Timeline.Item(tr("timeline.demo.deploy"))
            }
        } code: {
            """
            Moin.Timeline {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item(color: .green, dot: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }) {
                    Text("\(tr("timeline.demo.solve_issues"))")
                }
                Moin.Timeline.Item(dot: {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.orange)
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(tr("timeline.demo.tech_review"))")
                        Text("\(tr("timeline.demo.tech_time"))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Moin.Timeline.Item("\(tr("timeline.demo.deploy"))")
            }
            """
        }
    }

    // MARK: - Right

    private var rightExample: some View {
        ExampleSection(
            title: tr("timeline.right"),
            description: tr("timeline.right_desc")
        ) {
            Moin.Timeline(mode: .end) {
                Moin.Timeline.Item(tr("timeline.demo.create_project"))
                Moin.Timeline.Item(tr("timeline.demo.solve_issues"))
                Moin.Timeline.Item(tr("timeline.demo.tech_review"))
                Moin.Timeline.Item(tr("timeline.demo.deploy"))
            }
        } code: {
            """
            Moin.Timeline(mode: .end) {
                Moin.Timeline.Item("\(tr("timeline.demo.create_project"))")
                Moin.Timeline.Item("\(tr("timeline.demo.solve_issues"))")
                Moin.Timeline.Item("\(tr("timeline.demo.tech_review"))")
                Moin.Timeline.Item("\(tr("timeline.demo.deploy"))")
            }
            """
        }
    }

    // MARK: - Label

    private var labelExample: some View {
        ExampleSection(
            title: tr("timeline.label"),
            description: tr("timeline.label_desc")
        ) {
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(label: {
                    Text(tr("timeline.demo.morning"))
                }) {
                    Text(tr("timeline.demo.create_project"))
                }
                Moin.Timeline.Item(color: .green, label: {
                    Text(tr("timeline.demo.noon"))
                }) {
                    Text(tr("timeline.demo.solve_issues"))
                }
                Moin.Timeline.Item(color: .red, label: {
                    Text(tr("timeline.demo.afternoon"))
                }) {
                    Text(tr("timeline.demo.tech_review"))
                }
                Moin.Timeline.Item(label: {
                    Text(tr("timeline.demo.evening"))
                }) {
                    Text(tr("timeline.demo.deploy"))
                }
            }
        } code: {
            """
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(label: {
                    Text("\(tr("timeline.demo.morning"))")
                }) {
                    Text("\(tr("timeline.demo.create_project"))")
                }
                Moin.Timeline.Item(color: .green, label: {
                    Text("\(tr("timeline.demo.noon"))")
                }) {
                    Text("\(tr("timeline.demo.solve_issues"))")
                }
                Moin.Timeline.Item(color: .red, label: {
                    Text("\(tr("timeline.demo.afternoon"))")
                }) {
                    Text("\(tr("timeline.demo.tech_review"))")
                }
                Moin.Timeline.Item(label: {
                    Text("\(tr("timeline.demo.evening"))")
                }) {
                    Text("\(tr("timeline.demo.deploy"))")
                }
            }
            """
        }
    }
}
