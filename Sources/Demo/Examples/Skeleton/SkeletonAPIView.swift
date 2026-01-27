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
                items: [.init(id: "avatar.size"), .init(id: "avatar.shape"), .init(id: "avatar.active")],
                sectionId: "avatar"
            ),
            DocSidebarSection(
                title: "Skeleton.Button",
                items: [.init(id: "button.size"), .init(id: "button.shape"), .init(id: "button.block"), .init(id: "button.active")],
                sectionId: "button"
            ),
            DocSidebarSection(
                title: "Skeleton.Input",
                items: [.init(id: "input.size"), .init(id: "input.block"), .init(id: "input.active")],
                sectionId: "input"
            ),
            DocSidebarSection(
                title: "Skeleton.Image",
                items: [.init(id: "image.width"), .init(id: "image.height"), .init(id: "image.active")],
                sectionId: "image"
            ),
            DocSidebarSection(
                title: "Skeleton.Node",
                items: [.init(id: "node.active"), .init(id: "node.content")],
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
            VStack(spacing: 16) {
                Moin.Skeleton(avatar: false)
                    .frame(width: 300)
                Moin.Skeleton(avatar: true)
                    .frame(width: 300)
            }
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
            VStack(spacing: 16) {
                Moin.Skeleton(title: true)
                    .frame(width: 300)
                Moin.Skeleton(title: false)
                    .frame(width: 300)
            }
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
            VStack(spacing: 16) {
                Moin.Skeleton(title: true, paragraph: true)
                    .frame(width: 300)
                Moin.Skeleton(title: true, paragraph: false)
                    .frame(width: 300)
            }
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
            VStack(spacing: 16) {
                Moin.Skeleton(round: false)
                    .frame(width: 300)
                Moin.Skeleton(round: true)
                    .frame(width: 300)
            }
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
            description: "头像尺寸，支持预设值 .small、.default、.large 或自定义数值",
            sectionId: "avatar"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonAvatar(size: .small)
                Moin.SkeletonAvatar(size: .default)
                Moin.SkeletonAvatar(size: .large)
                Moin.SkeletonAvatar(size: 48)
            }
        } code: {
            """
            Moin.SkeletonAvatar(size: .small)
            Moin.SkeletonAvatar(size: .default)
            Moin.SkeletonAvatar(size: .large)
            Moin.SkeletonAvatar(size: 48)  // 自定义尺寸
            """
        }
        .scrollAnchor("avatar.size")
    }

    private var avatarShapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "AvatarShape",
            defaultValue: ".circle",
            description: "头像形状，支持 .circle（圆形）或 .square（方形）",
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
        .scrollAnchor("avatar.shape")
    }

    private var avatarActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: "是否显示动画效果",
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
        .scrollAnchor("avatar.active")
    }

    // MARK: - Button Property Cards

    private var buttonSizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Skeleton.Size",
            defaultValue: ".default",
            description: "按钮尺寸，支持预设值 .small、.default、.large 或自定义数值",
            sectionId: "button"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonButton(size: .small)
                Moin.SkeletonButton(size: .default)
                Moin.SkeletonButton(size: .large)
            }
        } code: {
            """
            Moin.SkeletonButton(size: .small)
            Moin.SkeletonButton(size: .default)
            Moin.SkeletonButton(size: .large)
            """
        }
        .scrollAnchor("button.size")
    }

    private var buttonShapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "ButtonShape",
            defaultValue: ".default",
            description: "按钮形状，支持 .default（默认）、.circle（圆形）、.round（圆角）、.square（方形）",
            sectionId: "button"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonButton(shape: .default)
                Moin.SkeletonButton(shape: .circle)
                Moin.SkeletonButton(shape: .round)
                Moin.SkeletonButton(shape: .square)
            }
        } code: {
            """
            Moin.SkeletonButton(shape: .default)
            Moin.SkeletonButton(shape: .circle)
            Moin.SkeletonButton(shape: .round)
            Moin.SkeletonButton(shape: .square)
            """
        }
        .scrollAnchor("button.shape")
    }

    private var buttonBlockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: "是否为块级元素（撑满容器宽度）",
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
        .scrollAnchor("button.block")
    }

    private var buttonActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: "是否显示动画效果",
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
        .scrollAnchor("button.active")
    }

    // MARK: - Input Property Cards

    private var inputSizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Skeleton.Size",
            defaultValue: ".default",
            description: "输入框尺寸，支持预设值 .small、.default、.large 或自定义数值",
            sectionId: "input",
            preview: {
                HStack(spacing: 16) {
                    Moin.SkeletonInput(size: .small)
                    Moin.SkeletonInput(size: .default)
                    Moin.SkeletonInput(size: .large)
                }
            },
            code: {
                """
                Moin.SkeletonInput(size: .small)
                Moin.SkeletonInput(size: .default)
                Moin.SkeletonInput(size: .large)
                """
            }
        )
        .scrollAnchor("input.size")
    }

    private var inputBlockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: "是否为块级元素（撑满容器宽度）",
            sectionId: "input"
        ) {
            HStack(spacing: 16) {
                Moin.SkeletonInput(block: false)
                Moin.SkeletonInput(block: true)
                    .frame(width: 200)
            }
        } code: {
            """
            Moin.SkeletonInput(block: false)
            Moin.SkeletonInput(block: true)
            """
        }
        .scrollAnchor("input.block")
    }

    private var inputActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: "是否显示动画效果",
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
        .scrollAnchor("input.active")
    }

    // MARK: - Image Property Cards

    private var imageWidthPropertyCard: some View {
        PropertyCard(
            name: "width",
            type: "CGFloat?",
            defaultValue: "nil",
            description: "图片宽度，nil 时使用默认值 96",
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
        .scrollAnchor("image.width")
    }

    private var imageHeightPropertyCard: some View {
        PropertyCard(
            name: "height",
            type: "CGFloat?",
            defaultValue: "nil",
            description: "图片高度，nil 时使用默认值 96",
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
        .scrollAnchor("image.height")
    }

    private var imageActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: "是否显示动画效果",
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
        .scrollAnchor("image.active")
    }

    // MARK: - Node Property Cards

    private var nodeActivePropertyCard: some View {
        PropertyCard(
            name: "active",
            type: "Bool",
            defaultValue: "false",
            description: "是否显示动画效果，当传入 content 时 active=true 会在内容上覆盖半透明骨架层",
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
        } code: {
            """
            Moin.SkeletonNode(active: false)
            Moin.SkeletonNode(active: true)
            Moin.SkeletonNode(active: true) {
                Circle().fill(Color.blue).frame(width: 40, height: 40)
            }
            """
        }
        .scrollAnchor("node.active")
    }

    private var nodeContentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "View?",
            defaultValue: "nil",
            description: "自定义内容，支持传入任意子视图。传入内容后，active=true 时会在内容上覆盖半透明骨架层",
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
                    Text("Content")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        } code: {
            """
            Moin.SkeletonNode()
            Moin.SkeletonNode(active: true) {
                Circle().fill(Color.blue).frame(width: 40, height: 40)
            }
            """
        }
        .scrollAnchor("node.content")
    }
}
