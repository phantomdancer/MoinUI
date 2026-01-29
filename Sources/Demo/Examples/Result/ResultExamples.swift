import SwiftUI
import MoinUI

struct ResultExamples: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "success", titleKey: "result.success"),
        AnchorItem(id: "info", titleKey: "result.info"),
        AnchorItem(id: "warning", titleKey: "result.warning"),
        AnchorItem(id: "error", titleKey: "result.error"),
        AnchorItem(id: "403", titleKey: "result.403"),
        AnchorItem(id: "404", titleKey: "result.404"),
        AnchorItem(id: "500", titleKey: "result.500"),
        AnchorItem(id: "customIcon", titleKey: "result.custom_icon")
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Result", anchors: anchors) { _ in
            successExample.id("success")
            infoExample.id("info")
            warningExample.id("warning")
            errorExample.id("error")
            unauthorizedExample.id("403")
            notFoundExample.id("404")
            serverErrorExample.id("500")
            customIconExample.id("customIcon")
        }
    }

    // MARK: - Success

    private var successExample: some View {
        ExampleSection(
            title: tr("result.success"),
            description: tr("result.success_desc")
        ) {
            Moin.Result(
                tr("result.demo.success_title"),
                subTitle: tr("result.demo.success_subtitle"),
                status: .success
            ) {
                HStack(spacing: 8) {
                    Moin.Button(tr("result.demo.go_console"), variant: .solid) {}
                    Moin.Button(tr("result.demo.buy_again")) {}
                }
            }
        } code: {
            """
            Moin.Result(
                "\(tr("result.demo.success_title"))",
                subTitle: "\(tr("result.demo.success_subtitle"))",
                status: .success
            ) {
                HStack(spacing: 8) {
                    Moin.Button("\(tr("result.demo.go_console"))", variant: .solid) {}
                    Moin.Button("\(tr("result.demo.buy_again"))") {}
                }
            }
            """
        }
    }

    // MARK: - Info

    private var infoExample: some View {
        ExampleSection(
            title: tr("result.info"),
            description: tr("result.info_desc")
        ) {
            Moin.Result(
                tr("result.demo.info_title"),
                subTitle: tr("result.demo.info_subtitle"),
                status: .info
            ) {
                Moin.Button(tr("result.demo.go_console"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(
                "\(tr("result.demo.info_title"))",
                subTitle: "\(tr("result.demo.info_subtitle"))",
                status: .info
            ) {
                Moin.Button("\(tr("result.demo.go_console"))", variant: .solid) {}
            }
            """
        }
    }

    // MARK: - Warning

    private var warningExample: some View {
        ExampleSection(
            title: tr("result.warning"),
            description: tr("result.warning_desc")
        ) {
            Moin.Result(
                tr("result.demo.warning_title"),
                subTitle: tr("result.demo.warning_subtitle"),
                status: .warning
            ) {
                Moin.Button(tr("result.demo.go_console"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(
                "\(tr("result.demo.warning_title"))",
                subTitle: "\(tr("result.demo.warning_subtitle"))",
                status: .warning
            ) {
                Moin.Button("\(tr("result.demo.go_console"))", variant: .solid) {}
            }
            """
        }
    }

    // MARK: - Error

    private var errorExample: some View {
        ExampleSection(
            title: tr("result.error"),
            description: tr("result.error_desc")
        ) {
            Moin.Result(
                tr("result.demo.error_title"),
                subTitle: tr("result.demo.error_subtitle"),
                status: .error
            ) {
                HStack(spacing: 8) {
                    Moin.Button(tr("result.demo.go_console"), variant: .solid) {}
                    Moin.Button(tr("result.demo.buy_again")) {}
                }
            }
        } code: {
            """
            Moin.Result(
                "\(tr("result.demo.error_title"))",
                subTitle: "\(tr("result.demo.error_subtitle"))",
                status: .error
            ) {
                HStack(spacing: 8) {
                    Moin.Button("\(tr("result.demo.go_console"))", variant: .solid) {}
                    Moin.Button("\(tr("result.demo.buy_again"))") {}
                }
            }
            """
        }
    }

    // MARK: - 403

    private var unauthorizedExample: some View {
        ExampleSection(
            title: tr("result.403"),
            description: tr("result.403_desc")
        ) {
            Moin.Result(
                "403",
                subTitle: tr("result.demo.403_subtitle"),
                status: .unauthorized
            ) {
                Moin.Button(tr("result.demo.back_home"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(
                "403",
                subTitle: "\(tr("result.demo.403_subtitle"))",
                status: .unauthorized
            ) {
                Moin.Button("\(tr("result.demo.back_home"))", variant: .solid) {}
            }
            """
        }
    }

    // MARK: - 404

    private var notFoundExample: some View {
        ExampleSection(
            title: tr("result.404"),
            description: tr("result.404_desc")
        ) {
            Moin.Result(
                "404",
                subTitle: tr("result.demo.404_subtitle"),
                status: .notFound
            ) {
                Moin.Button(tr("result.demo.back_home"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(
                "404",
                subTitle: "\(tr("result.demo.404_subtitle"))",
                status: .notFound
            ) {
                Moin.Button("\(tr("result.demo.back_home"))", variant: .solid) {}
            }
            """
        }
    }

    // MARK: - 500

    private var serverErrorExample: some View {
        ExampleSection(
            title: tr("result.500"),
            description: tr("result.500_desc")
        ) {
            Moin.Result(
                "500",
                subTitle: tr("result.demo.500_subtitle"),
                status: .serverError
            ) {
                Moin.Button(tr("result.demo.back_home"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(
                "500",
                subTitle: "\(tr("result.demo.500_subtitle"))",
                status: .serverError
            ) {
                Moin.Button("\(tr("result.demo.back_home"))", variant: .solid) {}
            }
            """
        }
    }

    // MARK: - Custom Icon

    private var customIconExample: some View {
        ExampleSection(
            title: tr("result.custom_icon"),
            description: tr("result.custom_icon_desc")
        ) {
            Moin.Result(status: .info) {
                Text(tr("result.demo.custom_icon_title"))
            } subTitle: {
                Text(tr("result.demo.custom_icon_subtitle"))
            } icon: {
                Image(systemName: "face.smiling")
                    .foregroundStyle(.orange)
            } extra: {
                Moin.Button(tr("result.demo.next"), variant: .solid) {}
            }
        } code: {
            """
            Moin.Result(status: .info) {
                Text("\(tr("result.demo.custom_icon_title"))")
            } subTitle: {
                Text("\(tr("result.demo.custom_icon_subtitle"))")
            } icon: {
                Image(systemName: "face.smiling")
                    .foregroundStyle(.orange)
            } extra: {
                Moin.Button("\(tr("result.demo.next"))", variant: .solid) {}
            }
            """
        }
    }
}
