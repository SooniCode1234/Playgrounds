import SwiftUI

// An extension for all custom Colors in this experience
public extension Color {
    static let drBackgroundGradient = Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5764705882, blue: 0.9137254902, alpha: 1)), Color(#colorLiteral(red: 0.5019607843, green: 0.8156862745, blue: 0.7803921569, alpha: 1))])
    static let drPurple             = Color(#colorLiteral(red: 0.3450980484485626, green: 0.33725491166114807, blue: 0.8392156958580017, alpha: 1))
    static let drTeal               = Color(#colorLiteral(red: 0.327569842338562, green: 0.7603339552879333, blue: 0.9458044767379761, alpha: 1))
    static let drFactOne            = Color(#colorLiteral(red: 0.09803921729326248, green: 0.12941177189350128, blue: 0.3137255012989044, alpha: 1))
    static let drFactTwo            = Color(#colorLiteral(red: 0.9882352948188782, green: 0.40392157435417175, blue: 0.3529411852359772, alpha: 1))
    static let drFactThree          = Color(#colorLiteral(red: 0.2235294133424759, green: 0.07450980693101883, blue: 0.7215686440467834, alpha: 1))
    static let drFactFour           = Color(#colorLiteral(red: 0.5137255191802979, green: 0.32156863808631897, blue: 0.9921568632125854, alpha: 1))
}

// A variable to get properties of the current screen
public let screen = UIScreen.main.bounds
