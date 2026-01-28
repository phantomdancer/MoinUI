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
                title: "Skeleton.Avatar",
                items: [
                    .init(id: "avatar.size", displayName: "size"),
                    .init(id: "avatar.shape", displayName: "shape"),
                    .init(id: "avatar.active", displayName: "active")
                ],
                sectionId: "avatar"
            ),
            DocSidebarSection(
                title: "Skeleton.Button",
                items: [
                    .init(id: "button.size", displayName: "size"),
                    .init(id: "button.shape", displayName: "shape"),
                    .init(id: "button.block", displayName: "block"),
                    .init(id: "button.active", displayName: "active")
                ],
                sectionId: "button"
            ),
            DocSidebarSection(
                title: "Skeleton.Input",
                items: [
                    .init(id: "input.size", displayName: "size"),
                    .init(id: "input.block", displayName: "block"),
                    .init(id: "input.active", displayName: "active")
                ],
                sectionId: "input"
            ),
            DocSidebarSection(
                title: "Skeleton.Image",
                items: [
                    .init(id: "image.width", displayName: "width"),
                    .init(id: "image.height", displayName: "height"),
                    .init(id: "image.active", displayName: "active")
                ],
                sectionId: "image"
            ),
            DocSidebarSection(
                title: "Skeleton.Node",
                items: [
                    .init(id: "node.active", displayName: "active"),
                    .init(id: "node.content", displayName: "content")
                ],
                sectionId: "node"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "skeleton"
        ) { sectionId in
            switch sectionId {
            case "skeleton":
                Text("Skeleton").font(.title3).fontWeight(.semibold)
            case "avatar":
                Text("Skeleton.Avatar").font(.title3).fontWeight(.semibold)
            case "button":
                Text("Skeleton.Button").font(.title3).fontWeight(.semibold)
            case "input":
                Text("Skeleton.Input").font(.title3).fontWeight(.semibold)
            case "image":
                Text("Skeleton.Image").font(.title3).fontWeight(.semibold)
            case "node":
                Text("Skeleton.Node").font(.title3).fontWeight(.semibold)
            default:
                EmptyView()
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Skeleton Properties
        case "active": activePropertyCard
        case "avatar": avatarPropertyCard
        case "title": titlePropertyCard
        case "paragraph": paragraphPropertyCard
        case "round": roundPropertyCard
        case "loading": loadingPropertyCard

        // Avatar Properties
        case "avatar.size": avatarSizePropertyCard
        case "avatar.shape": avatarShapePropertyCard
        case "avatar.active": avatarActivePropertyCard

        // Button Properties
        case "button.size": buttonSizePropertyCard
        case "button.shape": buttonShapePropertyCard
        case "button.block": buttonBlockPropertyCard
        case "button.active": buttonActivePropertyCard

        // Input Properties
        case "input.size": inputSizePropertyCard
        case "input.block": inputBlockPropertyCard
        case "input.active": inputActivePropertyCard

        // Image Properties
        case "image.width": imageWidthPropertyCard
        case "image.height": imageHeightPropertyCard
        case "image.active": imageActivePropertyCard

        // Node Properties
        case "node.active": nodeActivePropertyCard
        case "node.content": nodeContentPropertyCard

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
            HStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text(tr("skeleton.default")).font(.subheadline).foregroundStyle(.secondary)
                    Moin.Skeleton()
                }
                VStack(spacing: 12) {
                    Text(tr("skeleton.animation")).font(.subheadline).foregroundStyle(.secondary)
                    Moin.Skeleton(active: true)
                }
            }
            .frame(maxWidth: 500, alignment: .leading)
        } code: {
            """
            Moin.Skeleton(active: false)
            Moin.Skeleton(active: true)
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
            HStack(spacing: 24) {
                Moin.Skeleton(avatar: false)
                    .frame(width: 280)
                Moin.Skeleton(avatar: true)
                    .frame(width: 280)
            }
            .frame(maxWidth: 600, alignment: .leading)
        } code: {
            """
            Moin.Skeleton(avatar: false)
            Moin.Skeleton(avatar: true)
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
            HStack(spacing: 24) {
                Moin.Skeleton(title: true)
                    .frame(width: 280)
                Moin.Skeleton(title: false)
                    .frame(width: 280)
            }
            .frame(maxWidth: 600, alignment: .leading)
        } code: {
            """
            Moin.Skeleton(title: true)
            Moin.Skeleton(title: false)
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
            HStack(spacing: 24) {
                Moin.Skeleton(title: true, paragraph: true)
                    .frame(width: 280)
                Moin.Skeleton(title: true, paragraph: false)
                    .frame(width: 280)
            }
            .frame(maxWidth: 600, alignment: .leading)
        } code: {
            """
            Moin.Skeleton(paragraph: true)
            Moin.Skeleton(paragraph: false)
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
            HStack(spacing: 24) {
                Moin.Skeleton(round: false)
                    .frame(width: 280)
                Moin.Skeleton(round: true)
                    .frame(width: 280)
            }
            .frame(maxWidth: 600, alignment: .leading)
        } code: {
            """
            Moin.Skeleton(round: false)
            Moin.Skeleton(round: true)
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

                Moin.Skeleton(loading: isLoading) {
                    Text(tr("skeleton.actual_content"))
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(width: 300)
            }
        } code: {
            """
            Moin.Skeleton(loading: isLoading) {
                Text("Actual content")
            }
            """
        }
        .scrollAnchor("skeleton.loading")
    }

    // MARK: - Avatar Property Cards

    private var avatarSizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Skeleton.Size",
            defaultValue: ".default",
            description: tr("skeleton.api_avatar_size_desc"),
            sectionId: "avatar"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonAvatar(size: .small)
                Moin.SkeletonAvatar(size: .default)
                Moin.SkeletonAvatar(size: .large)
                Moin.SkeletonAvatar(size: 48)
            }
            .frame(maxWidth: 400, alignment: .leading)
        } code: {
            """
            Moin.SkeletonAvatar(size: .small)
            Moin.SkeletonAvatar(size: .default)
            Moin.SkeletonAvatar(size: .large)
            Moin.SkeletonAvatar(size: 48)  // \(tr("skeleton.code_custom_size"))
            """
        }
        .scrollAnchor("avatar.avatar.size")
    }

    private var avatarShapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "AvatarShape",
            defaultValue: ".circle",
            description: tr("skeleton.api_avatar_shape_desc"),
            sectionId: "avatar"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonAvatar(shape: .circle)
                Moin.SkeletonAvatar(shape: .square)
            }
        } code: {
            """
            Moin.SkeletonAvatar(shape: .circle)
            Moin.SkeletonAvatar(shape: .square)
            """
        }
        .scrollAnchor("avatar.avatar.shape")
    }

    private var avatarActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_active_desc"),
            sectionId: "avatar"
        ) {
            HStack(spacing: 32) {
                VStack {
                    Moin.SkeletonAvatar(active: false)
                    Text("active: false").font(.caption).foregroundStyle(.secondary)
                }
                VStack {
                    Moin.SkeletonAvatar(active: true)
                    Text("active: true").font(.caption).foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.SkeletonAvatar(active: false)
            Moin.SkeletonAvatar(active: true)
            """
        }
        .scrollAnchor("avatar.avatar.active")
    }

    // MARK: - Button Property Cards

    private var buttonSizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Skeleton.Size",
            defaultValue: ".default",
            description: tr("skeleton.api_button_size_desc"),
            sectionId: "button"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonButton(size: .small)
                Moin.SkeletonButton(size: .default)
                Moin.SkeletonButton(size: .large)
                Moin.SkeletonButton(size: 36)
            }
            .frame(maxWidth: 500, alignment: .leading)
        } code: {
            """
            Moin.SkeletonButton(size: .small)
            Moin.SkeletonButton(size: .default)
            Moin.SkeletonButton(size: .large)
            Moin.SkeletonButton(size: 36)  // \(tr("skeleton.code_custom_size"))
            """
        }
        .scrollAnchor("button.button.size")
    }

    private var buttonShapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "ButtonShape",
            defaultValue: ".default",
            description: tr("skeleton.api_button_shape_desc"),
            sectionId: "button"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonButton(shape: .default)
                Moin.SkeletonButton(shape: .circle)
                Moin.SkeletonButton(shape: .round)
                Moin.SkeletonButton(shape: .square)
            }
            .frame(maxWidth: 400, alignment: .leading)
        } code: {
            """
            Moin.SkeletonButton(shape: .default)
            Moin.SkeletonButton(shape: .circle)
            Moin.SkeletonButton(shape: .round)
            Moin.SkeletonButton(shape: .square)
            """
        }
        .scrollAnchor("button.button.shape")
    }

    private var buttonBlockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_block_desc"),
            sectionId: "button"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonButton(block: false)
                Moin.SkeletonButton(block: true)
                    .frame(width: 150)
            }
        } code: {
            """
            Moin.SkeletonButton(block: false)
            Moin.SkeletonButton(block: true)
            """
        }
        .scrollAnchor("button.button.block")
    }

    private var buttonActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_active_desc"),
            sectionId: "button"
        ) {
            HStack(spacing: 32) {
                VStack {
                    Moin.SkeletonButton(active: false)
                    Text("active: false").font(.caption).foregroundStyle(.secondary)
                }
                VStack {
                    Moin.SkeletonButton(active: true)
                    Text("active: true").font(.caption).foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.SkeletonButton(active: false)
            Moin.SkeletonButton(button: true)
            """
        }
        .scrollAnchor("button.button.active")
    }

    // MARK: - Input Property Cards

    private var inputSizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Skeleton.Size",
            defaultValue: ".default",
            description: tr("skeleton.api_input_size_desc"),
            sectionId: "input"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonInput(size: .small)
                Moin.SkeletonInput(size: .default)
                Moin.SkeletonInput(size: .large)
                Moin.SkeletonInput(size: 44)
            }
            .frame(maxWidth: 500, alignment: .leading)
        } code: {
            """
            Moin.SkeletonInput(size: .small)
            Moin.SkeletonInput(size: .default)
            Moin.SkeletonInput(size: .large)
            Moin.SkeletonInput(size: 44)  // \(tr("skeleton.code_custom_size"))
            """
        }
        .scrollAnchor("input.input.size")
    }

    private var inputBlockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_block_desc"),
            sectionId: "input"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonInput(block: false)
                Moin.SkeletonInput(block: true)
                    .frame(width: 200)
            }
            .frame(maxWidth: 400, alignment: .leading)
        } code: {
            """
            Moin.SkeletonInput(block: false)
            Moin.SkeletonInput(block: true)
            """
        }
        .scrollAnchor("input.input.block")
    }

    private var inputActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_active_desc"),
            sectionId: "input"
        ) {
            HStack(spacing: 32) {
                VStack {
                    Moin.SkeletonInput(active: false)
                    Text("active: false").font(.caption).foregroundStyle(.secondary)
                }
                VStack {
                    Moin.SkeletonInput(active: true)
                    Text("active: true").font(.caption).foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.SkeletonInput(active: false)
            Moin.SkeletonInput(active: true)
            """
        }
        .scrollAnchor("input.input.active")
    }

    // MARK: - Image Property Cards

    private var imageWidthPropertyCard: some View {
        PropertyCard(
            name: "width",
            type: "CGFloat?",
            defaultValue: "nil",
            description: tr("skeleton.api_image_width_desc"),
            sectionId: "image"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonImage(width: nil)
                Moin.SkeletonImage(width: 120)
            }
        } code: {
            """
            Moin.SkeletonImage()
            Moin.SkeletonImage(width: 120)
            """
        }
        .scrollAnchor("image.image.width")
    }

    private var imageHeightPropertyCard: some View {
        PropertyCard(
            name: "height",
            type: "CGFloat?",
            defaultValue: "nil",
            description: tr("skeleton.api_image_height_desc"),
            sectionId: "image"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonImage(height: nil)
                Moin.SkeletonImage(width: 120, height: 80)
            }
        } code: {
            """
            Moin.SkeletonImage()
            Moin.SkeletonImage(width: 120, height: 80)
            """
        }
        .scrollAnchor("image.image.height")
    }

    private var imageActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_active_desc"),
            sectionId: "image"
        ) {
            HStack(spacing: 32) {
                VStack {
                    Moin.SkeletonImage(active: false)
                    Text("active: false").font(.caption).foregroundStyle(.secondary)
                }
                VStack {
                    Moin.SkeletonImage(active: true)
                    Text("active: true").font(.caption).foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.SkeletonImage(active: false)
            Moin.SkeletonImage(active: true)
            """
        }
        .scrollAnchor("image.image.active")
    }

    // MARK: - Node Property Cards

    private var nodeActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: tr("skeleton.api_node_active_desc"),
            sectionId: "node"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonNode(active: false)
                Moin.SkeletonNode(active: true)
                Moin.SkeletonNode(active: true) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                }
            }
            .frame(maxWidth: 400, alignment: .leading)
        } code: {
            """
            Moin.SkeletonNode(active: false)
            Moin.SkeletonNode(active: true)
            Moin.SkeletonNode(active: true) {
                Circle().fill(Color.blue).frame(width: 40, height: 40)
            }
            """
        }
        .scrollAnchor("node.node.active")
    }

    private var nodeContentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "View?",
            defaultValue: "nil",
            description: tr("skeleton.api_node_content_desc"),
            sectionId: "node"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonNode()
                Moin.SkeletonNode(active: true) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                }
                Moin.SkeletonNode {
                    Text(tr("skeleton.content"))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: 400, alignment: .leading)
        } code: {
            """
            Moin.SkeletonNode()
            Moin.SkeletonNode(active: true) {
                Circle().fill(Color.blue).frame(width: 40, height: 40)
            }
            Moin.SkeletonNode {
                Text("\(tr("skeleton.content"))")
            }
            """
        }
        .scrollAnchor("node.node.content")
    }
}
