import SwiftUI

/// Moin - 墨影UI macOS组件库命名空间
public enum Moin {
    public static let version: String = _MoinVersion

    // MARK: - Component Factories (Moin.Button(), Moin.Tag(), etc.)

    public static let Button = _MoinButtonFactory()
    public static let Tag = _MoinTagFactory()
    public static let Badge = _MoinBadgeFactory()
    public static let Avatar = _MoinAvatarFactory()
    public static let Divider = _MoinDividerFactory()
    public static let Space = _MoinSpaceFactory()
    public static let Empty = _MoinEmptyFactory()
    public static let Spin = _MoinSpinFactory()
    public static let Statistic = _MoinStatisticFactory()
    public static let Alert = _MoinAlertFactory()
    public static let Progress = _MoinProgressFactory()
    public static let Switch = _MoinSwitchFactory()
    public static let Checkbox = _MoinCheckboxFactory()
    public static let Radio = _MoinRadioFactory()
    public static let Skeleton = _MoinSkeletonFactory()
}

