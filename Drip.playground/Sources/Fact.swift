import SwiftUI

public struct Fact: Identifiable {
    public var id: Int
    public let name: String
    public let color: Color
    
    public init(id: Int, name: String, color: Color) {
        self.id = id
        self.name = name
        self.color = color
    }
}


