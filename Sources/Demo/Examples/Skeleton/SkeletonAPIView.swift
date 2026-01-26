import SwiftUI
import MoinUI

// MARK: - SkeletonAPIView

struct SkeletonAPIView: View {
    @Localized var tr
    @State private var isLoading = true

    // MARK: - API Sections

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Skeleton",
                items: [.init(id: "active"), .init(id: "avatar"), .init(id: "title"), .init(id: "paragraph"), .init(id: "round"), .init(id: "loading")],
                sectionId: "skeleton"
            ),
            DocSidebarSection(
                title: "Skeleton.Element",
                items: [.init(id: "element.avatar"), .init(id: "element.button"), .init(id: "element.input"), .init(id: "element.image")],
                sectionId: "element"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "skeleton"
        ) { sectionId in
            if sectionId == "skeleton" {
                Text("Skeleton").font(.title3).fontWeight(.semibold)
            } else if sectionId == "element" {
                Text("Skeleton.Element").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "active": activePropertyCard
        case "avatar": avatarPropertyCard
        case "title": titlePropertyCard
        case "paragraph": paragraphPropertyCard
        case "round": roundPropertyCard
        case "loading": loadingPropertyCard
        case "element.avatar": elementAvatarCard
        case "element.button": elementButtonCard
        case "element.input": elementInputCard
        case "element.image": elementImageCard
        default: EmptyView()
        }
    }

    // MARK: - Skeleton Property Cards

    private var activePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.prop_active"),
            sectionId: "skeleton"
        ) {
            HStack(spacing: 32) {
                VStack {
                    Skeleton(active: false)
                        .frame(width: 150)
                    Text("active: false").font(.caption).foregroundStyle(.secondary)
                }
                VStack {
                    Skeleton(active: true)
                        .frame(width: 150)
                    Text("active: true").font(.caption).foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Skeleton(active: false)
            Skeleton(active: true)
            """
        }
        .scrollAnchor("skeleton.active")
    }

    private var avatarPropertyCard: some View {
        PropertyCard(
            name: "avatar",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.prop_avatar"),
            sectionId: "skeleton"
        ) {
            VStack(spacing: 16) {
                Skeleton(active: true, avatar: false)
                    .frame(width: 300)
                Skeleton(active: true, avatar: true)
                    .frame(width: 300)
            }
        } code: {
            """
            Skeleton(active: true, avatar: false)
            Skeleton(active: true, avatar: true)
            """
        }
        .scrollAnchor("skeleton.avatar")
    }

    private var titlePropertyCard: some View {
        PropertyCard(
            name: "title",
            type: "Bool",
            defaultValue: "true",
            description: tr("skeleton.prop_title"),
            sectionId: "skeleton"
        ) {
            VStack(spacing: 16) {
                Skeleton(active: true, title: true)
                    .frame(width: 300)
                Skeleton(active: true, title: false)
                    .frame(width: 300)
            }
        } code: {
            """
            Skeleton(active: true, title: true)
            Skeleton(active: true, title: false)
            """
        }
        .scrollAnchor("skeleton.title")
    }

    private var paragraphPropertyCard: some View {
        PropertyCard(
            name: "paragraph",
            type: "Bool",
            defaultValue: "true",
            description: tr("skeleton.prop_paragraph"),
            sectionId: "skeleton"
        ) {
            VStack(spacing: 16) {
                Skeleton(active: true, title: true, paragraph: true)
                    .frame(width: 300)
                Skeleton(active: true, title: true, paragraph: false)
                    .frame(width: 300)
            }
        } code: {
            """
            Skeleton(active: true, paragraph: true)
            Skeleton(active: true, paragraph: false)
            """
        }
        .scrollAnchor("skeleton.paragraph")
    }

    private var roundPropertyCard: some View {
        PropertyCard(
            name: "round",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.prop_round"),
            sectionId: "skeleton"
        ) {
            VStack(spacing: 16) {
                Skeleton(active: true, round: false)
                    .frame(width: 300)
                Skeleton(active: true, round: true)
                    .frame(width: 300)
            }
        } code: {
            """
            Skeleton(active: true, round: false)
            Skeleton(active: true, round: true)
            """
        }
        .scrollAnchor("skeleton.round")
    }

    private var loadingPropertyCard: some View {
        PropertyCard(
            name: "loading",
            type: "Bool",
            defaultValue: "true",
            description: tr("skeleton.prop_loading"),
            sectionId: "skeleton"
        ) {
            VStack(spacing: 12) {
                Toggle(tr("skeleton.toggle_loading"), isOn: $isLoading)
                    .frame(width: 160)

                Skeleton(loading: isLoading, active: true) {
                    Text(tr("skeleton.actual_content"))
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(width: 300)
            }
        } code: {
            """
            Skeleton(loading: isLoading, active: true) {
                Text("Actual content")
            }
            """
        }
        .scrollAnchor("skeleton.loading")
    }

    // MARK: - Skeleton.Element Cards

    private var elementAvatarCard: some View {
        PropertyCard(
            name: "Avatar(size:shape:active:)",
            type: "Skeleton.Avatar",
            defaultValue: "-",
            description: tr("skeleton.element_avatar"),
            sectionId: "element"
        ) {
            HStack(spacing: 16) {
                Skeleton.Avatar(active: true)
                Skeleton.Avatar(shape: .square, active: true)
                Skeleton.Avatar(size: .large, active: true)
                Skeleton.Avatar(size: .small, active: true)
            }
        } code: {
            """
            Skeleton.Avatar(active: true)
            Skeleton.Avatar(shape: .square, active: true)
            Skeleton.Avatar(size: .large, active: true)
            """
        }
        .scrollAnchor("element.avatar")
    }

    private var elementButtonCard: some View {
        PropertyCard(
            name: "Button(size:shape:block:active:)",
            type: "Skeleton.Button",
            defaultValue: "-",
            description: tr("skeleton.element_button"),
            sectionId: "element"
        ) {
            HStack(spacing: 16) {
                Skeleton.Button(active: true)
                Skeleton.Button(shape: .circle, active: true)
                Skeleton.Button(shape: .round, active: true)
            }
        } code: {
            """
            Skeleton.Button(active: true)
            Skeleton.Button(shape: .circle, active: true)
            Skeleton.Button(shape: .round, active: true)
            """
        }
        .scrollAnchor("element.button")
    }

    private var elementInputCard: some View {
        PropertyCard(
            name: "Input(size:active:)",
            type: "Skeleton.Input",
            defaultValue: "-",
            description: tr("skeleton.element_input"),
            sectionId: "element"
        ) {
            Skeleton.Input(active: true)
                .frame(width: 200)
        } code: {
            "Skeleton.Input(active: true)"
        }
        .scrollAnchor("element.input")
    }

    private var elementImageCard: some View {
        PropertyCard(
            name: "Image(width:height:active:)",
            type: "Skeleton.Image",
            defaultValue: "-",
            description: tr("skeleton.element_image"),
            sectionId: "element"
        ) {
            HStack(spacing: 16) {
                Skeleton.Image(active: true)
                Skeleton.Image(width: 120, height: 80, active: true)
            }
        } code: {
            """
            Skeleton.Image(active: true)
            Skeleton.Image(width: 120, height: 80, active: true)
            """
        }
        .scrollAnchor("element.image")
    }
}
