import SwiftUI

public extension Moin {
    struct Progress: View {
        public enum Variant {
            case line
            case circle
            case dashboard
        }

        public enum Status: String {
            case normal
            case success
            case exception
            case active
        }

        public enum Size: Hashable {
            case `default`
            case small
            case number(CGFloat)
            case size(width: CGFloat, height: CGFloat)

            var width: CGFloat? {
                switch self {
                case .default: return 120
                case .small: return 80
                case .number(let val): return val
                case .size(let w, _): return w
                }
            }

            var height: CGFloat? {
                 switch self {
                case .default: return 120
                case .small: return 80
                case .number(let val): return val
                case .size(_, let h): return h
                }
            }
        }

        public enum StrokeLinecap {
            case round
            case butt
            case square

            var swiftUIStyle: CGLineCap {
                switch self {
                case .round: return .round
                case .butt: return .butt
                case .square: return .square
                }
            }
        }

        // MARK: - PercentPosition (v5.18.0)
        public enum PercentAlign {
            case start, center, end
        }

        public enum PercentType {
            case inner, outer
        }

        public struct PercentPosition {
            public var align: PercentAlign
            public var type: PercentType

            public init(align: PercentAlign = .end, type: PercentType = .outer) {
                self.align = align
                self.type = type
            }
        }

        // MARK: - SuccessProps
        public struct SuccessProps {
            public var percent: Double
            public var strokeColor: Color?

            public init(percent: Double, strokeColor: Color? = nil) {
                self.percent = percent
                self.strokeColor = strokeColor
            }
        }

        // MARK: - GradientColor
        public struct GradientColor {
            public var stops: [Gradient.Stop]
            public var startPoint: UnitPoint
            public var endPoint: UnitPoint

            public init(stops: [Gradient.Stop], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) {
                self.stops = stops
                self.startPoint = startPoint
                self.endPoint = endPoint
            }

            public init(colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) {
                self.stops = colors.indices.map { Gradient.Stop(color: colors[$0], location: CGFloat($0) / CGFloat(colors.count - 1)) }
                self.startPoint = startPoint
                self.endPoint = endPoint
            }

            public init(from: Color, to: Color) {
                self.stops = [.init(color: from, location: 0.0), .init(color: to, location: 1.0)]
                self.startPoint = .leading
                self.endPoint = .trailing
            }
        }

        // MARK: - GapPosition / GapPlacement
        public enum GapPosition {
            case top, bottom, left, right
        }

        public enum GapPlacement {
            case top, bottom, start, end
        }

        // MARK: - CircleSteps (v5.16.0)
        public struct CircleStepsConfig: Hashable {
            public var count: Int
            public var gap: CGFloat

            public init(count: Int, gap: CGFloat = 2) {
                self.count = count
                self.gap = gap
            }
        }

        let percent: Double
        let format: ((Double) -> AnyView)?
        let status: Status?
        let showInfo: Bool
        let strokeWidth: CGFloat?
        let strokeLinecap: StrokeLinecap
        let strokeColor: Color?
        let strokeColors: [Color]?
        let strokeGradient: GradientColor?
        let railColor: Color?
        let width: CGFloat?
        let success: SuccessProps?
        let gapDegree: Double?
        let gapPosition: GapPosition
        let gapPlacement: GapPlacement?
        let type: Variant
        let size: Size
        let steps: Int?
        let circleSteps: CircleStepsConfig?
        let percentPosition: PercentPosition

        @Environment(\.moinToken) private var globalToken
        @Environment(\.moinProgressToken) private var progressToken
        @Environment(\.colorScheme) private var colorScheme

        public init(
            percent: Double = 0,
            format: ((Double) -> AnyView)? = nil,
            status: Status? = nil,
            showInfo: Bool = true,
            strokeWidth: CGFloat? = nil,
            strokeLinecap: StrokeLinecap = .round,
            strokeColor: Color? = nil,
            strokeColors: [Color]? = nil,
            strokeGradient: GradientColor? = nil,
            railColor: Color? = nil,
            width: CGFloat? = nil,
            success: SuccessProps? = nil,
            gapDegree: Double? = nil,
            gapPosition: GapPosition = .bottom,
            gapPlacement: GapPlacement? = nil,
            type: Variant = .line,
            size: Size = .default,
            steps: Int? = nil,
            circleSteps: CircleStepsConfig? = nil,
            percentPosition: PercentPosition = PercentPosition()
        ) {
            self.percent = percent
            self.format = format
            self.status = status
            self.showInfo = showInfo
            self.strokeWidth = strokeWidth
            self.strokeLinecap = strokeLinecap
            self.strokeColor = strokeColor
            self.strokeColors = strokeColors
            self.strokeGradient = strokeGradient
            self.railColor = railColor
            self.width = width
            self.success = success
            self.gapDegree = gapDegree
            self.gapPosition = gapPosition
            self.gapPlacement = gapPlacement
            self.type = type
            self.size = size
            self.steps = steps
            self.circleSteps = circleSteps
            self.percentPosition = percentPosition
        }
        
        // Calculations
        private var validPercent: Double { max(0, min(100, percent)) }
        
        private var currentStatus: Status {
            if let status = status { return status }
            if validPercent >= 100 { return .success }
            return .normal
        }

        private var effectiveStrokeWidth: CGFloat {
            if let w = strokeWidth { return w }
            if type == .line {
                return size == .small ? 6 : 8
            } else {
                return size == .small ? 6 : 6 // AntD circle seems 6 default?
            }
        }
        
        private func statusFill(isRail: Bool = false) -> AnyShapeStyle {
            if isRail {
                return AnyShapeStyle(railColor ?? progressToken.remainingColor)
            }
            
            if let gradient = strokeGradient {
                return AnyShapeStyle(LinearGradient(stops: gradient.stops, startPoint: gradient.startPoint, endPoint: gradient.endPoint))
            }
            
            if let strokeColor = strokeColor { return AnyShapeStyle(strokeColor) }
            
            let color: Color
            switch currentStatus {
            case .normal, .active: color = progressToken.defaultColor
            case .success: color = globalToken.colorSuccess
            case .exception: color = globalToken.colorDanger
            }
            return AnyShapeStyle(color)
        }
        
        // Helper to parse fontSize string like "1em"
        private func parseFontSize(_ sizeStr: String) -> CGFloat {
            if sizeStr.hasSuffix("em"), let val = Double(sizeStr.dropLast(2)) {
                return globalToken.fontSize * CGFloat(val)
            }
            // Fallback or other units parsing could go here
            return globalToken.fontSize
        }

        public var body: some View {
            Group {
                switch type {
                case .line:
                    if let steps = steps, steps > 0 {
                        renderSteps()
                    } else {
                        renderLine()
                    }
                case .circle, .dashboard:
                    renderCircle()
                }
            }
            .animation(.easeInOut(duration: globalToken.motionDurationSlow), value: percent)
        }
        
        // MARK: - Renderers

        private func renderLine() -> some View {
            let isInner = percentPosition.type == .inner
            let isCenterOuter = percentPosition.align == .center && percentPosition.type == .outer

            return Group {
                if isCenterOuter {
                    VStack(spacing: globalToken.marginXXS) {
                        lineBarView()
                        if showInfo {
                            renderInfo()
                        }
                    }
                } else if isInner {
                    lineBarView(withInnerInfo: showInfo)
                } else {
                    HStack(spacing: globalToken.marginXS) {
                        lineBarView()
                        if showInfo {
                            renderInfo()
                        }
                    }
                }
            }
        }

        @ViewBuilder
        private func lineBarView(withInnerInfo: Bool = false) -> some View {
            GeometryReader { geo in
                let w = geo.size.width
                let radius: CGFloat = strokeLinecap == .round ? progressToken.lineBorderRadius : 0

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(railColor ?? progressToken.remainingColor)
                        .frame(height: effectiveStrokeWidth)

                    if let success = success, success.percent > 0 {
                        let sP = max(0, min(100, success.percent))
                        RoundedRectangle(cornerRadius: radius)
                            .fill(success.strokeColor ?? globalToken.colorSuccess)
                            .frame(width: w * (sP / 100.0), height: effectiveStrokeWidth)
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: radius)
                            .fill(statusFill())
                            .frame(width: w * (validPercent / 100.0), height: effectiveStrokeWidth)

                        if withInnerInfo {
                            HStack {
                                if percentPosition.align == .end || percentPosition.align == .center {
                                    Spacer(minLength: 0)
                                }
                                renderInfo(isInner: true)
                                    .padding(.horizontal, 4)
                                if percentPosition.align == .start || percentPosition.align == .center {
                                    Spacer(minLength: 0)
                                }
                            }
                            .frame(width: w * (validPercent / 100.0), height: effectiveStrokeWidth)
                        }
                    }

                    if currentStatus == .active {
                        ActiveAnimationView(width: w, height: effectiveStrokeWidth, radius: radius)
                    }
                }
            }
            .frame(height: effectiveStrokeWidth)
        }

        private func renderSteps() -> some View {
            let count = steps ?? 0
            let activeCount = Int(round((validPercent / 100.0) * Double(count)))
            let isInner = percentPosition.type == .inner
            let isCenterOuter = percentPosition.align == .center && percentPosition.type == .outer

            return Group {
                if isCenterOuter {
                    VStack(spacing: globalToken.marginXXS) {
                        stepsBarView(count: count, activeCount: activeCount)
                        if showInfo { renderInfo() }
                    }
                } else if isInner {
                    stepsBarView(count: count, activeCount: activeCount)
                } else {
                    HStack(spacing: globalToken.marginXS) {
                        stepsBarView(count: count, activeCount: activeCount)
                        if showInfo { renderInfo() }
                    }
                }
            }
        }

        @ViewBuilder
        private func stepsBarView(count: Int, activeCount: Int) -> some View {
            HStack(spacing: 2) {
                ForEach(0..<count, id: \.self) { index in
                    let isActive = index < activeCount
                    let fillColor: AnyShapeStyle = {
                        if isActive {
                            if let colors = strokeColors, index < colors.count {
                                return AnyShapeStyle(colors[index])
                            }
                            return statusFill()
                        }
                        return statusFill(isRail: true)
                    }()
                    Capsule()
                        .fill(fillColor)
                        .frame(height: effectiveStrokeWidth)
                }
            }
        }
        
        private func renderCircle() -> some View {
            let isDashboard = type == .dashboard
            let gapDeg = gapDegree ?? (isDashboard ? 75.0 : 0.0)

            let effectiveGapPos = resolveGapPosition()

            let totalDegrees = 360.0 - gapDeg
            let fraction = totalDegrees / 360.0

            let baseRotation: Double
            if isDashboard || gapDeg > 0 {
                switch effectiveGapPos {
                case .top: baseRotation = -90
                case .bottom: baseRotation = 90
                case .left: baseRotation = 180
                case .right: baseRotation = 0
                }
            } else {
                baseRotation = -90
            }

            let rotation: Angle = .degrees(baseRotation + (gapDeg > 0 ? gapDeg / 2 : 0))
            let w = size.width ?? 120
            let circleStrokeWidth = effectiveCircleStrokeWidth(canvasSize: w)
            let isSmallCircle = w <= 20

            return ZStack {
                if let cs = circleSteps {
                    renderCircleSteps(
                        config: cs,
                        canvasSize: w,
                        strokeWidth: circleStrokeWidth,
                        gapDeg: gapDeg,
                        rotation: rotation
                    )
                } else {
                    Circle()
                        .trim(from: 0, to: fraction)
                        .stroke(railColor ?? progressToken.remainingColor, style: StrokeStyle(lineWidth: circleStrokeWidth, lineCap: strokeLinecap.swiftUIStyle))
                        .rotationEffect(rotation)

                    Circle()
                        .trim(from: 0, to: (validPercent / 100.0) * fraction)
                        .stroke(statusFill(), style: StrokeStyle(lineWidth: circleStrokeWidth, lineCap: strokeLinecap.swiftUIStyle))
                        .rotationEffect(rotation)
                }

                if showInfo && !isSmallCircle {
                    renderInfo(isCircle: true)
                }
            }
            .frame(width: w, height: w)
            .ifLet(isSmallCircle && showInfo ? infoText() : nil) { view, text in
                view.help(text)
            }
        }

        private func resolveGapPosition() -> GapPosition {
            if let placement = gapPlacement {
                switch placement {
                case .top: return .top
                case .bottom: return .bottom
                case .start: return .left
                case .end: return .right
                }
            }
            return gapPosition
        }

        private func effectiveCircleStrokeWidth(canvasSize: CGFloat) -> CGFloat {
            if let w = strokeWidth { return w }
            let minWidth: CGFloat = 3
            let percentBased = canvasSize * 0.06
            return max(minWidth, percentBased)
        }

        @ViewBuilder
        private func renderCircleSteps(
            config: CircleStepsConfig,
            canvasSize: CGFloat,
            strokeWidth: CGFloat,
            gapDeg: Double,
            rotation: Angle
        ) -> some View {
            let totalDegrees = 360.0 - gapDeg
            let gapBetweenSteps = config.gap
            let totalGapDegrees = Double(config.count) * gapBetweenSteps
            let availableDegrees = totalDegrees - totalGapDegrees
            let stepDegrees = availableDegrees / Double(config.count)
            let activeCount = Int(round((validPercent / 100.0) * Double(config.count)))

            ForEach(0..<config.count, id: \.self) { index in
                let startOffset = Double(index) * (stepDegrees + gapBetweenSteps)
                let startFraction = startOffset / 360.0
                let endFraction = (startOffset + stepDegrees) / 360.0
                let isActive = index < activeCount
                let fillStyle = isActive ? statusFill() : statusFill(isRail: true)

                Circle()
                    .trim(from: startFraction, to: endFraction)
                    .stroke(fillStyle, style: StrokeStyle(lineWidth: strokeWidth, lineCap: strokeLinecap.swiftUIStyle))
                    .rotationEffect(rotation)
            }
        }

        private func infoText() -> String {
            if currentStatus == .exception { return "Error" }
            if currentStatus == .success { return "Done" }
            return "\(Int(percent))%"
        }

        private func renderInfo(isCircle: Bool = false, isInner: Bool = false) -> some View {
            Group {
                if let format = format {
                    format(percent)
                } else {
                    if currentStatus == .exception {
                        Image(systemName: isCircle ? "xmark" : "xmark.circle.fill")
                            .font(.system(size: isCircle ? parseFontSize(progressToken.circleIconFontSize) : globalToken.fontSize))
                            .foregroundStyle(globalToken.colorDanger)
                    } else if currentStatus == .success {
                        Image(systemName: isCircle ? "checkmark" : "checkmark.circle.fill")
                            .font(.system(size: isCircle ? parseFontSize(progressToken.circleIconFontSize) : globalToken.fontSize))
                            .foregroundStyle(globalToken.colorSuccess)
                    } else {
                        Text("\(Int(percent))%")
                            .font(.system(size: isCircle ? parseFontSize(progressToken.circleTextFontSize) : (isInner ? effectiveStrokeWidth * 0.7 : globalToken.fontSize)))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            .foregroundStyle(isInner ? .white : (isCircle ? progressToken.circleTextColor : globalToken.colorText))
        }
    }
}

// MARK: - Internal Views
extension Moin.Progress {
    struct ActiveAnimationView: View {
        let width: CGFloat
        let height: CGFloat
        let radius: CGFloat
        @State private var offset: CGFloat = -1.0
        
        var body: some View {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.white)
                .frame(width: width, height: height)
                .opacity(0.3)
                .mask(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .white.opacity(0.8), .clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: width * 0.4) // Shimmer width
                        .offset(x: offset * width)
                )
                .onAppear {
                    withAnimation(.linear(duration: 2.4).repeatForever(autoreverses: false)) {
                        offset = 1.0
                    }
                }
        }
    }
}

// MARK: - View Extension
private extension View {
    @ViewBuilder
    func ifLet<T, Content: View>(_ value: T?, @ViewBuilder transform: (Self, T) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}
