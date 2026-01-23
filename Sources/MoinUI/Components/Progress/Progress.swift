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
            case number(CGFloat) // width/height if circle, irrelevant for line? AntD Line only height from strokeWidth or default.
            case size(width: CGFloat, height: CGFloat) 
            // In AntD:
            // Line: size is irrelevant for width (100%), height by strokeWidth.
            // Circle/Dashboard: size applies to canvas size.
            
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
        
        // Supports percent and strokeColor
        public struct SuccessProps {
            public var percent: Double
            public var strokeColor: Color?
            
            public init(percent: Double, strokeColor: Color? = nil) {
                self.percent = percent
                self.strokeColor = strokeColor
            }
        }
        
        // Gradient Support
        // Gradient Support
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
            
            /// Ant Design specific gradient from object 
            /// { '0%': '#108ee9', '100%': '#87d068' }
            public init(from: Color, to: Color) {
                self.stops = [.init(color: from, location: 0.0), .init(color: to, location: 1.0)]
                self.startPoint = .leading
                self.endPoint = .trailing
            }
        }

        public enum GapPosition {
            case top, bottom, left, right
        }

        let percent: Double
        let format: ((Double) -> AnyView)?
        let status: Status?
        let showInfo: Bool
        let strokeWidth: CGFloat?
        let strokeLinecap: StrokeLinecap
        let strokeColor: Color?
        let strokeGradient: GradientColor?
        let railColor: Color?
        let width: CGFloat? // Deprecated in AntD, mapped to size
        let success: SuccessProps?
        let gapDegree: Double? // For dashboard
        let gapPosition: GapPosition // top/bottom/leading/trailing -> top/bottom/left/right
        let type: Variant
        let size: Size
        let steps: Int?
        
        // Environment for Token
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
            strokeGradient: GradientColor? = nil,
            railColor: Color? = nil,
            width: CGFloat? = nil,
            success: SuccessProps? = nil,
            gapDegree: Double? = nil,
            gapPosition: GapPosition = .bottom, // .bottom for default dashboard
            type: Variant = .line,
            size: Size = .default,
            steps: Int? = nil
        ) {
            self.percent = percent
            self.format = format
            self.status = status
            self.showInfo = showInfo
            self.strokeWidth = strokeWidth
            self.strokeLinecap = strokeLinecap
            self.strokeColor = strokeColor
            self.strokeGradient = strokeGradient
            self.railColor = railColor
            self.width = width
            self.success = success
            self.gapDegree = gapDegree
            self.gapPosition = gapPosition
            self.type = type
            self.size = size
            self.steps = steps
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
            HStack(spacing: globalToken.marginXS) {
                GeometryReader { geo in
                    let w = geo.size.width
                    let radius: CGFloat = strokeLinecap == .round ? progressToken.lineBorderRadius : 0
                    
                    ZStack(alignment: .leading) {
                        // Rail
                        RoundedRectangle(cornerRadius: radius)
                            .fill(railColor ?? progressToken.remainingColor)
                            .frame(height: effectiveStrokeWidth)
                        
                        // Success Segment
                        if let success = success, success.percent > 0 {
                            let sP = max(0, min(100, success.percent))
                            RoundedRectangle(cornerRadius: radius)
                                .fill(success.strokeColor ?? globalToken.colorSuccess)
                                .frame(width: w * (sP / 100.0), height: effectiveStrokeWidth)
                        }
                        
                        // Main Segment
                        RoundedRectangle(cornerRadius: radius)
                            .fill(statusFill())
                            .frame(width: w * (validPercent / 100.0), height: effectiveStrokeWidth)
                            
                        // Animation for active
                        if currentStatus == .active {
                           ActiveAnimationView(width: w, height: effectiveStrokeWidth, radius: radius)
                        }
                    }
                }
                .frame(height: effectiveStrokeWidth)
                
                if showInfo {
                    renderInfo()
                }
            }
        }
        
        private func renderSteps() -> some View {
             HStack(spacing: globalToken.marginXS) {
                // Determine item count
                let count = steps ?? 0
                let activeCount = Int((validPercent / 100.0) * Double(count))
                
                HStack(spacing: 2) {
                    ForEach(0..<count, id: \.self) { index in
                        Capsule() // Steps usually look like small capsules/rects
                            .fill(index < activeCount ? statusFill() : statusFill(isRail: true))
                            .frame(height: effectiveStrokeWidth)
                    }
                }
                
                if showInfo {
                    renderInfo()
                }
             }
        }
        
        private func renderCircle() -> some View {
            let isDashboard = type == .dashboard
            // Default Gap: Dashboard 75deg. Circle 0.
            let gapDeg = gapDegree ?? (isDashboard ? 75.0 : 0.0)
            
            // AntD gapPosition: 'top' | 'bottom' | 'left' | 'right'
            // Default dashboard: bottom.
            // Default circle: top start (for 0 gap).
            
            // Implementation:
            // Circle trim 0-1. 0 is 3 o'clock.
            // Rotate to move gap.
            
            // Logic for Dashboard with gap 75 at bottom:
            // 75deg gap centered at 90deg (bottom).
            // Start: 90 + 75/2 = 127.5.
            // End: 127.5 + (360 - 75) = 412.5.
            
            // SwiftUI Trim 0 - percent.
            // Base Circle: Trim(0, 1 - gap/360).
            // Rotation:
            
            let totalDegrees = 360.0 - gapDeg
            let fraction = totalDegrees / 360.0
            
            // Rotation calculation based on Position
            // If Circle (no gap): -90 (start at top)
            // If Dashboard:
            //   top: -90 + gap/2
            //   bottom: 90 + gap/2
            //   left: 180 + gap/2
            //   right: 0 + gap/2
            
            let baseRotation: Double
            if isDashboard {
                switch gapPosition {
                case .top: baseRotation = -90
                case .bottom: baseRotation = 90
                case .left: baseRotation = 180
                case .right: baseRotation = 0
                }
            } else {
                baseRotation = -90
            }
            
            let rotation: Angle = .degrees(baseRotation + (isDashboard ? gapDeg / 2 : 0))
            
            let w = size.width ?? 120
            
            return ZStack {
                 // Rail
                Circle()
                    .trim(from: 0, to: fraction)
                    .stroke(railColor ?? progressToken.remainingColor, style: StrokeStyle(lineWidth: effectiveStrokeWidth, lineCap: strokeLinecap.swiftUIStyle))
                    .rotationEffect(rotation)
                
                // Track
                Circle()
                    .trim(from: 0, to: (validPercent / 100.0) * fraction)
                    .stroke(statusFill(), style: StrokeStyle(lineWidth: effectiveStrokeWidth, lineCap: strokeLinecap.swiftUIStyle))
                    .rotationEffect(rotation)
                
                if showInfo {
                    renderInfo(isCircle: true)
                }
            }
            .frame(width: w, height: w)
        }
        
        private func renderInfo(isCircle: Bool = false) -> some View {
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
                            .font(.system(size: isCircle ? parseFontSize(progressToken.circleTextFontSize) : globalToken.fontSize))
                    }
                }
            }
            .foregroundStyle(isCircle ? progressToken.circleTextColor : globalToken.colorText)
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
