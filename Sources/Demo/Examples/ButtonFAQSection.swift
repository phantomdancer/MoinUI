import SwiftUI
import MoinUI

struct ButtonFAQSection: View {
    @ObservedObject private var localization = MoinUILocalization.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
            Text(localization.tr("faq.title"))
                .font(.title2)
                .fontWeight(.semibold)

            // Q: ghost vs outlined
            FAQItem(
                question: localization.tr("faq.ghost_vs_outlined.q"),
                content: {
                    VStack(alignment: .leading, spacing: Constants.Spacing.sm) {
                        Text(localization.tr("faq.ghost_vs_outlined.a1"))

                        VStack(alignment: .leading, spacing: Constants.Spacing.xs) {
                            BulletPoint(localization.tr("faq.ghost_vs_outlined.a1_outlined"))
                            BulletPoint(localization.tr("faq.ghost_vs_outlined.a1_ghost"))
                        }
                        .padding(.leading, Constants.Spacing.md)

                        Text(localization.tr("faq.ghost_vs_outlined.a2"))
                            .padding(.top, Constants.Spacing.xs)
                    }
                }
            )
        }
    }
}
