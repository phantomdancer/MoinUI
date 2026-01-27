import SwiftUI
import MoinUI

struct AlertExamples: View {
    @Localized var tr
    @State private var showSuccess = true
    @State private var showInfo = true
    @State private var showWarning = true
    @State private var showError = true
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "alert.basic"),
        AnchorItem(id: "closable", titleKey: "alert.closable"),
        AnchorItem(id: "icon", titleKey: "alert.icon"),
        AnchorItem(id: "description", titleKey: "alert.with_description"),
        AnchorItem(id: "action", titleKey: "alert.action"),
        AnchorItem(id: "banner", titleKey: "alert.banner")
    ]
    
    var body: some View {
        ExamplePageWithAnchor(pageName: "Alert", anchors: anchors) { _ in
            basicExample.id("basic")
            closableExample.id("closable")
            iconExample.id("icon")
            descriptionExample.id("description")
            actionExample.id("action")
            bannerExample.id("banner")
        }
    }
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("alert.basic"),
            description: tr("alert.basic_desc")
        ) {
            VStack(spacing: 12) {
                Moin.Alert(type: .success, title: tr("alert.demo.success"))
                Moin.Alert(type: .info, title: tr("alert.demo.info"))
                Moin.Alert(type: .warning, title: tr("alert.demo.warning"))
                Moin.Alert(type: .error, title: tr("alert.demo.error"))
            }
        } code: {
            """
            Moin.Alert(type: .success, title: "\(tr("alert.demo.success"))")
            Moin.Alert(type: .info, title: "\(tr("alert.demo.info"))")
            Moin.Alert(type: .warning, title: "\(tr("alert.demo.warning"))")
            Moin.Alert(type: .error, title: "\(tr("alert.demo.error"))")
            """
        }
    }
    
    private var closableExample: some View {
        ExampleSection(
            title: tr("alert.closable"),
            description: tr("alert.closable_desc")
        ) {
            VStack(spacing: 12) {
                if showSuccess {
                    Moin.Alert(
                        type: .success,
                        title: tr("alert.demo.success_closable"),
                        closable: true,
                        onClose: { showSuccess = false }
                    )
                }
                if showInfo {
                    Moin.Alert(
                        type: .info,
                        title: tr("alert.demo.info_closable"),
                        closable: true,
                        onClose: { showInfo = false }
                    )
                }
            }
        } code: {
            """
            Moin.Alert(
                type: .success,
                title: "\(tr("alert.demo.success_closable"))",
                closable: true,
                onClose: { /* handle close */ }
            )
            """
        }
    }
    
    private var iconExample: some View {
        ExampleSection(
            title: tr("alert.icon"),
            description: tr("alert.icon_desc")
        ) {
            VStack(spacing: 12) {
                Moin.Alert(type: .success, title: tr("alert.demo.success"), showIcon: true)
                Moin.Alert(type: .info, title: tr("alert.demo.info"), showIcon: true)
                Moin.Alert(type: .warning, title: tr("alert.demo.warning"), showIcon: true)
                Moin.Alert(type: .error, title: tr("alert.demo.error"), showIcon: true)
            }
        } code: {
            """
            Moin.Alert(type: .success, title: "\(tr("alert.demo.success"))", showIcon: true)
            Moin.Alert(type: .info, title: "\(tr("alert.demo.info"))", showIcon: true)
            """
        }
    }
    
    private var descriptionExample: some View {
        ExampleSection(
            title: tr("alert.with_description"),
            description: tr("alert.with_description_desc")
        ) {
            VStack(spacing: 12) {
                Moin.Alert(
                    type: .success,
                    title: tr("alert.demo.success_title"),
                    description: tr("alert.demo.success_description"),
                    showIcon: true
                )
                Moin.Alert(
                    type: .info,
                    title: tr("alert.demo.info_title"),
                    description: tr("alert.demo.info_description"),
                    showIcon: true
                )
            }
        } code: {
            """
            Moin.Alert(
                type: .success,
                title: "\(tr("alert.demo.success_title"))",
                description: "\(tr("alert.demo.success_description"))",
                showIcon: true
            )
            """
        }
    }
    
    private var actionExample: some View {
        ExampleSection(
            title: tr("alert.action"),
            description: tr("alert.action_desc")
        ) {
            VStack(spacing: 12) {
                // Success Tips with UNDO
                Moin.Alert(
                    type: .success,
                    title: tr("alert.demo.action.success_title"),
                    showIcon: true,
                    closable: true
                ) {
                    Moin.Button(tr("alert.demo.action.undo"), size: .small, variant: .text)
                }
                
                // Error Text with Detail
                Moin.Alert(
                    type: .error,
                    title: tr("alert.demo.action.error_title"),
                    description: tr("alert.demo.action.error_desc"),
                    showIcon: true
                ) {
                    Moin.Button(tr("alert.demo.action.detail"), color: .danger, size: .small)
                }
                
                // Warning Text with Done
                Moin.Alert(
                    type: .warning,
                    title: tr("alert.demo.action.warning_title"),
                    closable: true
                ) {
                    Moin.Button(tr("alert.demo.action.done"), size: .small, variant: .text)
                }
                
                // Info Text with Accept/Decline
                Moin.Alert(
                    type: .info,
                    title: tr("alert.demo.action.info_title"),
                    description: tr("alert.demo.action.info_desc"),
                    closable: true
                ) {
                    Moin.Space(size: .small, direction: .vertical) {
                        Moin.Button(tr("alert.demo.action.accept"), color: .primary, size: .small)
                        Moin.Button(tr("alert.demo.action.decline"), color: .danger, size: .small, ghost: true)
                    }
                }
            }
        } code: {
            """
            Moin.Alert(
                type: .success, 
                title: "\(tr("alert.demo.action.success_title"))", 
                showIcon: true, 
                closable: true
            ) {
                Moin.Button("\(tr("alert.demo.action.undo"))", size: .small, variant: .text)
            }
            
            Moin.Alert(
                type: .error,
                title: "\(tr("alert.demo.action.error_title"))",
                description: "\(tr("alert.demo.action.error_desc"))",
                showIcon: true
            ) {
                Moin.Button("\(tr("alert.demo.action.detail"))", color: .danger, size: .small)
            }
            """
        }
    }
    
    private var bannerExample: some View {
        ExampleSection(
            title: tr("alert.banner"),
            description: tr("alert.banner_desc")
        ) {
            VStack(spacing: 0) {
                Moin.Alert(type: .warning, title: tr("alert.demo.banner_warning"), banner: true)
                Moin.Alert(type: .error, title: tr("alert.demo.banner_error"), closable: true, banner: true)
            }
        } code: {
            """
            Moin.Alert(type: .warning, title: "\(tr("alert.demo.banner_warning"))", banner: true)
            Moin.Alert(type: .error, title: "\(tr("alert.demo.banner_error"))", closable: true, banner: true)
            """
        }
    }
}
