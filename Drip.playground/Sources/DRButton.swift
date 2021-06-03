import SwiftUI

public struct DRButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    public init(title: String,
                backgroundColor: Color,
                _ action: @escaping () -> Void) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.title2, design: .rounded))
                .bold()
                .foregroundColor(Color.white)
                .tracking(0.35)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 40)
                .frame(maxHeight: 68)
                .background(backgroundColor)
                .cornerRadius(13)
        }
    }
}


