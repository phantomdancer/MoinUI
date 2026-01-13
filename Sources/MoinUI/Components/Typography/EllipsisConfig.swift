import SwiftUI

public extension Moin.Typography {
    /// 省略号配置
    struct EllipsisConfig {
        /// 最大行数
        public let rows: Int
        /// 是否可展开/收起
        public let expandable: Bool
        /// 是否显示展开/收起切换
        public let collapsible: Bool
        /// 展开按钮文案
        public let expandSymbol: String
        /// 收起按钮文案
        public let collapseSymbol: String
        /// 悬停时显示完整内容的 tooltip
        public let tooltip: Bool
        /// 默认是否展开
        public let defaultExpanded: Bool
        /// 展开/收起回调
        public let onExpand: ((Bool) -> Void)?

        public init(
            rows: Int = 1,
            expandable: Bool = false,
            collapsible: Bool = false,
            expandSymbol: String = "展开",
            collapseSymbol: String = "收起",
            tooltip: Bool = false,
            defaultExpanded: Bool = false,
            onExpand: ((Bool) -> Void)? = nil
        ) {
            self.rows = rows
            self.expandable = expandable
            self.collapsible = collapsible
            self.expandSymbol = expandSymbol
            self.collapseSymbol = collapseSymbol
            self.tooltip = tooltip
            self.defaultExpanded = defaultExpanded
            self.onExpand = onExpand
        }

        /// 简单行数限制
        public static func rows(_ count: Int) -> EllipsisConfig {
            EllipsisConfig(rows: count)
        }

        /// 可展开配置
        public static func expandable(
            rows: Int = 3,
            collapsible: Bool = true,
            expandSymbol: String = "展开",
            collapseSymbol: String = "收起"
        ) -> EllipsisConfig {
            EllipsisConfig(
                rows: rows,
                expandable: true,
                collapsible: collapsible,
                expandSymbol: expandSymbol,
                collapseSymbol: collapseSymbol
            )
        }
    }
}
