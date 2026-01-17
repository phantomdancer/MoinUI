import SwiftUI
import MoinUI

// MARK: - API 属性卡片扩展

extension ButtonDocView {
    
    // MARK: - Icon 属性卡片
    
    var iconPropertyCard: some View {
        PropertyCard(
            name: "icon",
            type: "String?",
            defaultValue: "nil",
            description: tr("button.api.icon"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button("Search", color: .primary, icon: "magnifyingglass") {}
                Moin.Button("Add", color: .success, icon: "plus") {}
                Moin.Button(icon: "heart.fill", color: .danger, shape: .circle) {}
            }
        } code: {
            """
Moin.Button("Search", icon: "magnifyingglass") {}
Moin.Button("Add", icon: "plus") {}
Moin.Button(icon: "heart.fill", shape: .circle) {}
"""
        }
    }
    
    // MARK: - Loading 属性卡片
    
    var loadingPropertyCard: some View {
        PropertyCard(
            name: "loading",
            type: "Moin.ButtonLoading",
            defaultValue: "false",
            description: tr("button.api.loading"),
            sectionId: "api"
        ) {
            Moin.Button("Loading", color: .primary, loading: true) {}
        } code: {
            "Moin.Button(\"Loading\", loading: true) {}"
        }
    }
    
    // MARK: - Disabled 属性卡片
    
    var disabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.isDisabled"),
            sectionId: "api"
        ) {
            Moin.Button("Disabled", color: .primary, isDisabled: true) {}
        } code: {
            "Moin.Button(\"Disabled\", isDisabled: true) {}"
        }
    }
    
    // MARK: - Block 属性卡片
    
    var blockPropertyCard: some View {
        PropertyCard(
            name: "isBlock",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.isBlock"),
            sectionId: "api"
        ) {
            Moin.Button("Block", color: .primary, isBlock: true) {}
        } code: {
            "Moin.Button(\"Block\", isBlock: true) {}"
        }
    }
    
    // MARK: - Ghost 属性卡片
    
    var ghostPropertyCard: some View {
        PropertyCard(
            name: "isGhost",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.isGhost"),
            sectionId: "api"
        ) {
            ZStack {
                Color(white: 0.8)
                    .frame(height: 60)
                    .cornerRadius(8)
                Moin.Button("Ghost", color: .primary, isGhost: true) {}
            }
        } code: {
            "Moin.Button(\"Ghost\", isGhost: true) {}"
        }
    }
    
    // MARK: - IconPlacement 属性卡片
    
    var iconPlacementPropertyCard: some View {
        PropertyCard(
            name: "iconPlacement",
            type: "Moin.ButtonIconPlacement",
            defaultValue: ".start",
            description: tr("button.api.iconPlacement"),
            enumValues: ".start | .end",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                ForEach(Moin.ButtonIconPlacement.allCases, id: \.self) { placement in
                    Moin.Button(
                        placement.description.capitalized,
                        color: .primary,
                        icon: placement == .start ? "arrow.left" : "arrow.right",
                        iconPlacement: placement
                    ) {}
                }
            }
        } code: {
            """
Moin.Button("Start", icon: "arrow.left", iconPlacement: .start) {}
Moin.Button("End", icon: "arrow.right", iconPlacement: .end) {}
"""
        }
    }
}
