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
        } tryIt: {
            HStack(spacing: Moin.Constants.Spacing.md) {
                TextField("Icon name", text: $selectedIcon)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150)
                Moin.Button("Button", color: .primary, icon: selectedIcon.isEmpty ? nil : selectedIcon) {}
            }
        } code: {
            selectedIcon.isEmpty ? "Moin.Button(\"Hello\") {}" : "Moin.Button(\"Hello\", icon: \"\(selectedIcon)\") {}"
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
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button("Normal", color: .primary) {}
                Moin.Button("Loading", color: .primary, loading: true) {}
            }
        } tryIt: {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Toggle("", isOn: $isLoading)
                    .toggleStyle(.switch)
                Moin.Button("Button", color: .primary, loading: Moin.ButtonLoading(isLoading)) {}
            }
        } code: {
            isLoading ? "Moin.Button(\"Hello\", loading: true) {}" : "Moin.Button(\"Hello\") {}"
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
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button("Normal", color: .primary) {}
                Moin.Button("Disabled", color: .primary, isDisabled: true) {}
            }
        } tryIt: {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Toggle("", isOn: $isDisabled)
                    .toggleStyle(.switch)
                Moin.Button("Button", color: .primary, isDisabled: isDisabled) {}
            }
        } code: {
            isDisabled ? "Moin.Button(\"Hello\", isDisabled: true) {}" : "Moin.Button(\"Hello\") {}"
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
            VStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button("Normal", color: .primary) {}
                Moin.Button("Block", color: .primary, isBlock: true) {}
            }
        } tryIt: {
            VStack(spacing: Moin.Constants.Spacing.sm) {
                Toggle("isBlock", isOn: $isBlock)
                    .toggleStyle(.switch)
                Moin.Button("Button", color: .primary, isBlock: isBlock) {}
            }
        } code: {
            isBlock ? "Moin.Button(\"Hello\", isBlock: true) {}" : "Moin.Button(\"Hello\") {}"
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
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 60)
                    .cornerRadius(8)
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button("Ghost", color: .primary, isGhost: true) {}
                    Moin.Button("Normal", color: .primary) {}
                }
            }
        } tryIt: {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Toggle("", isOn: $isGhost)
                    .toggleStyle(.switch)
                Moin.Button("Button", color: .primary, isGhost: isGhost) {}
            }
        } code: {
            isGhost ? "Moin.Button(\"Hello\", isGhost: true) {}" : "Moin.Button(\"Hello\") {}"
        }
    }
    
    // MARK: - IconPlacement 属性卡片
    
    var iconPlacementPropertyCard: some View {
        PropertyCard(
            name: "iconPlacement",
            type: "Moin.ButtonIconPlacement",
            defaultValue: ".start",
            description: tr("button.api.iconPlacement"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button("Start", color: .primary, icon: "arrow.left", iconPlacement: .start) {}
                Moin.Button("End", color: .primary, icon: "arrow.right", iconPlacement: .end) {}
            }
        } tryIt: {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Picker("", selection: $selectedIconPlacement) {
                    Text("start").tag(Moin.ButtonIconPlacement.start)
                    Text("end").tag(Moin.ButtonIconPlacement.end)
                }
                .pickerStyle(.segmented)
                .frame(width: 150)
                Moin.Button("Button", color: .primary, icon: "star.fill", iconPlacement: selectedIconPlacement) {}
            }
        } code: {
            "Moin.Button(\"Hello\", icon: \"star.fill\", iconPlacement: .\(selectedIconPlacement)) {}"
        }
    }
}
