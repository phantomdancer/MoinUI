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
    public static let Rate = _MoinRateFactory()

    // MARK: - Type Aliases

    // Checkbox
    public typealias CheckboxOption<T: Hashable> = _CheckboxOption<T>

    // Radio
    public typealias RadioOption<T: Hashable> = _RadioOption<T>

    // Space
    public typealias SpaceAlignment = _SpaceAlignment

    // Progress
    public typealias ProgressGapPosition = _Progress.GapPosition

    // Skeleton
    public typealias SkeletonAvatar = _Skeleton.Avatar
    public typealias SkeletonButton = _Skeleton.Button
    public typealias SkeletonInput = _Skeleton.Input
    public typealias SkeletonImage = _Skeleton.SkeletonImage
    public typealias SkeletonNode = _Skeleton.Node
    public typealias SkeletonTitleProps = _Skeleton.TitleProps
    public typealias SkeletonParagraphProps = _Skeleton.ParagraphProps
}

