import SwiftUI
import MoinUI

// MARK: - Shared Views for Space Examples and API

struct SpaceSizeDemoView: View {
    @Localized var tr
    
    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            HStack {
                Text("small:").frame(width: 60, alignment: .leading)
                Moin.Space(size: .small) {
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                }
            }
            HStack {
                Text("medium:").frame(width: 60, alignment: .leading)
                Moin.Space(size: .medium) {
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                }
            }
            HStack {
                Text("large:").frame(width: 60, alignment: .leading)
                Moin.Space(size: .large) {
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                }
            }
            HStack {
                Text("\(tr("space.custom")):").frame(width: 60, alignment: .leading)
                Moin.Space(size: 24) {
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                    Moin.Button(tr("button.label.button"), color: .primary) {}
                }
            }
        }
    }
}

struct SpaceDirectionDemoView: View {
    @Localized var tr
    
    var body: some View {
        HStack(spacing: 40) {
            VStack(alignment: .leading) {
                Text(tr("space.horizontal")).font(.caption).foregroundStyle(.secondary)
                Moin.Space(direction: .horizontal) {
                    Moin.Button("1") {}
                    Moin.Button("2") {}
                    Moin.Button("3") {}
                }
            }
            
            VStack(alignment: .leading) {
                Text(tr("space.vertical")).font(.caption).foregroundStyle(.secondary)
                Moin.Space(direction: .vertical) {
                    Moin.Button("1") {}
                    Moin.Button("2") {}
                    Moin.Button("3") {}
                }
            }
        }
    }
}

// For API view mostly, expands to show both H and V if needed, 
// but SpaceExamples only showed Vertical as "Direction Example" because Horizontal is default/basic.
// However, the user wants "richer" examples in API too. 
// So I will create a reusable view that shows specific Direction example or maybe both?
// In SpaceExamples.swift, directionExample ONLY shows vertical.
// In SpaceAPIView.swift (my recent edit), I showed BOTH horizontal and vertical side-by-side.
// The user said "use the examples from Examples in API".
// This implies the API should look like Examples.
// But Examples.swift only has Vertical in direction section.
// Maybe I should stick to what Examples.swift has?
// NO, "inside API ... examples aren't good ... use ones from examples".
// The user wants valid, rich examples. 
// SpaceExamples.swift `directionExample` is just vertical stack of buttons.
// Let's make `SpaceDirectionDemoView` exactly that.
// And for API, if I want to show Horizontal too, I can just use `SpaceBasicDemoView` (if exists) or just make another one?
// Actually, `SpaceExamples.swift` has `basicExample` (Horizontal) and `directionExample` (Vertical).
// So I should probably extract `basicExample` too.

struct SpaceBasicDemoView: View {
    @Localized var tr
    
    var body: some View {
        Moin.Space {
            Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
            Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
            Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
        }
    }
}


struct SpaceAlignmentDemoView: View {
    @Localized var tr
    
    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // Horizontal
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text(tr("space.horizontal")).font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 20) {
                    alignmentBox(title: "start", alignment: .start)
                    alignmentBox(title: "center", alignment: .center)
                    alignmentBox(title: "end", alignment: .end)
                }
            }
            
            // Vertical
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text(tr("space.vertical")).font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 20) {
                    alignmentBoxVertical(title: "start", alignment: .start)
                    alignmentBoxVertical(title: "center", alignment: .center)
                    alignmentBoxVertical(title: "end", alignment: .end)
                }
            }
        }
    }
    
    // Helper views moved inside here or as private/internal
    private func alignmentBox(title: String, alignment: Moin.SpaceAlignment) -> some View {
        VStack {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Moin.Space(alignment: alignment) {
                Text("1").font(.caption).padding(.vertical, 8).padding(.horizontal, 12).background(Color.primary.opacity(0.1))
                Text("2").font(.caption).padding(.vertical, 16).padding(.horizontal, 12).background(Color.primary.opacity(0.1))
                Text("3").font(.caption).padding(.vertical, 12).padding(.horizontal, 12).background(Color.primary.opacity(0.1))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color.primary.opacity(0.1))
            )
        }
    }

    private func alignmentBoxVertical(title: String, alignment: Moin.SpaceAlignment) -> some View {
        VStack {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Moin.Space(direction: .vertical, alignment: alignment) {
                Text("1").font(.caption).padding(.vertical, 4).padding(.horizontal, 12).background(Color.primary.opacity(0.1))
                Text("2").font(.caption).padding(.vertical, 4).padding(.horizontal, 24).background(Color.primary.opacity(0.1))
                Text("3").font(.caption).padding(.vertical, 4).padding(.horizontal, 18).background(Color.primary.opacity(0.1))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color.primary.opacity(0.1))
            )
        }
    }
}

struct SpaceWrapDemoView: View {
    @Localized var tr
    
    var body: some View {
        ResizableContainer(initialWidth: 400, minWidth: 200, maxWidth: 600) {
            Moin.Space(wrap: true) {
                ForEach(1...6, id: \.self) { i in
                    Moin.Button("\(tr("button.label.button")) \(i)", color: .primary) {}
                }
            }
        }
    }
}

struct SpaceSeparatorDemoView: View {
    @Localized var tr
    
    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // Horizontal with divider
            Text("\(tr("space.horizontal")):").font(.caption).foregroundStyle(.secondary)
            Moin.Space(size: .small, separator: { Moin.Divider(orientation: .vertical) }) {
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "1")) {}
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "2")) {}
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "3")) {}
            }

            // Vertical with custom separator
            Text("\(tr("space.vertical")):").font(.caption).foregroundStyle(.secondary)
            Moin.Space(direction: .vertical, separator: { Moin.Divider() }) {
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "1")) {}
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "2")) {}
                Moin.Typography.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "3")) {}
            }

            // Custom text separator
            Text("\(tr("space.custom_separator")):").font(.caption).foregroundStyle(.secondary)
            Moin.Space(separator: { Text("|").foregroundStyle(.secondary) }) {
                Text(tr("space.nav_home"))
                Text(tr("space.nav_products"))
                Text(tr("space.nav_about"))
            }

            // Icon separator
            Text("\(tr("space.icon_separator")):").font(.caption).foregroundStyle(.secondary)
            Moin.Space(separator: {
                Image(systemName: "star.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(.orange)
            }) {
                Text("Swift")
                Text("SwiftUI")
                Text("MoinUI")
            }
        }
    }
}

struct SpaceSeparatorSimpleDemoView: View {
    @Localized var tr
    
    var body: some View {
        Moin.Space(size: .small, separator: {
            Image(systemName: "star.fill")
                .font(.system(size: 8))
                .foregroundStyle(.orange)
        }) {
            Moin.Typography.Link("Item 1") {}
            Moin.Typography.Link("Item 2") {}
            Moin.Typography.Link("Item 3") {}
        }
    }
}
