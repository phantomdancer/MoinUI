import SwiftUI

// MARK: - Result Status

/// Result 状态枚举
public enum _ResultStatus: String {
    case success
    case error
    case info
    case warning
    case notFound      // 404
    case unauthorized  // 403
    case serverError   // 500
}

// MARK: - Result Component

public struct _Result<Title: View, SubTitle: View, Icon: View, Extra: View, Body: View>: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinResultToken) private var resultToken

    // MARK: - Properties

    let status: _ResultStatus
    let title: Title
    let subTitle: SubTitle
    let customIcon: Icon?
    let extra: Extra
    let content: Body?

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            // Icon
            iconView
                .padding(.bottom, token.paddingLG)

            // Title
            if Title.self != EmptyView.self {
                title
                    .font(.system(size: resultToken.titleFontSize, weight: .medium))
                    .foregroundStyle(token.colorText)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, token.paddingXS)
            }

            // SubTitle
            if SubTitle.self != EmptyView.self {
                subTitle
                    .font(.system(size: resultToken.subtitleFontSize))
                    .foregroundStyle(token.colorTextSecondary)
                    .multilineTextAlignment(.center)
            }

            // Extra (操作区)
            if Extra.self != EmptyView.self {
                extra
                    .padding(.top, resultToken.extraMargin)
            }

            // Body (内容区)
            if Body.self != EmptyView.self, let content = content {
                content
                    .padding(.top, resultToken.extraMargin)
            }
        }
        .padding(resultToken.padding)
        .frame(maxWidth: .infinity)
    }

    // MARK: - Icon View

    @ViewBuilder
    private var iconView: some View {
        if let customIcon = customIcon, Icon.self != EmptyView.self {
            customIcon
                .font(.system(size: resultToken.iconFontSize))
        } else {
            defaultIcon
                .font(.system(size: resultToken.iconFontSize))
                .foregroundStyle(iconColor)
        }
    }

    private var defaultIcon: Image {
        switch status {
        case .success:
            return Image(systemName: "checkmark.circle.fill")
        case .error:
            return Image(systemName: "xmark.circle.fill")
        case .info:
            return Image(systemName: "info.circle.fill")
        case .warning:
            return Image(systemName: "exclamationmark.triangle.fill")
        case .notFound:
            return Image(systemName: "questionmark.folder.fill")
        case .unauthorized:
            return Image(systemName: "lock.circle.fill")
        case .serverError:
            return Image(systemName: "exclamationmark.icloud.fill")
        }
    }

    private var iconColor: Color {
        switch status {
        case .success:
            return token.colorSuccess
        case .error:
            return token.colorDanger
        case .info:
            return token.colorInfo
        case .warning:
            return token.colorWarning
        case .notFound, .unauthorized, .serverError:
            return token.colorTextTertiary
        }
    }
}

// MARK: - Factory

public struct _MoinResultFactory {
    public init() {}

    /// 简单调用 (仅标题字符串)
    public func callAsFunction(
        status: _ResultStatus = .info,
        title: String
    ) -> _Result<Text, EmptyView, EmptyView, EmptyView, EmptyView> {
        _Result(
            status: status,
            title: Text(title),
            subTitle: EmptyView(),
            customIcon: nil as EmptyView?,
            extra: EmptyView(),
            content: nil
        )
    }

    /// 标题 + 副标题 (字符串)
    public func callAsFunction(
        status: _ResultStatus = .info,
        title: String,
        subTitle: String
    ) -> _Result<Text, Text, EmptyView, EmptyView, EmptyView> {
        _Result(
            status: status,
            title: Text(title),
            subTitle: Text(subTitle),
            customIcon: nil as EmptyView?,
            extra: EmptyView(),
            content: nil
        )
    }

    /// 完整调用 (ViewBuilder)
    public func callAsFunction<T: View, S: View, I: View, E: View, B: View>(
        status: _ResultStatus = .info,
        @ViewBuilder title: () -> T,
        @ViewBuilder subTitle: () -> S = { EmptyView() },
        @ViewBuilder icon: () -> I? = { nil as EmptyView? },
        @ViewBuilder extra: () -> E = { EmptyView() },
        @ViewBuilder body: () -> B = { EmptyView() }
    ) -> _Result<T, S, I, E, B> {
        _Result(
            status: status,
            title: title(),
            subTitle: subTitle(),
            customIcon: icon(),
            extra: extra(),
            content: body()
        )
    }

    /// 字符串标题 + ViewBuilder 其他
    public func callAsFunction<E: View>(
        status: _ResultStatus = .info,
        title: String,
        subTitle: String? = nil,
        @ViewBuilder extra: () -> E
    ) -> _Result<Text, Text?, EmptyView, E, EmptyView> {
        _Result(
            status: status,
            title: Text(title),
            subTitle: subTitle.map { Text($0) },
            customIcon: nil as EmptyView?,
            extra: extra(),
            content: nil
        )
    }
}
