import SwiftUI

public struct FunFactView: View {
    @State private var facts = [
        Fact(id: 0, name: "A person can survive a week with no water", color: Color.drFactOne),
        Fact(id: 1, name: "97% of the world's water is undrinkable", color: Color.drFactTwo),
        Fact(id: 2, name: "Water regulates the Earth's temperature", color: Color.drFactThree),
        Fact(id: 3, name: "Water expands by 9% when it freezes", color: Color.drFactFour)
    ]
    @State private var sourcePresenting = false
    @State private var changeWave = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var scaleAnimating = false
    
    
    public init() { }
    
    public var body: some View {
        ZStack {
            LinearGradient(gradient: Color.drBackgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            
            VStack {
                
                Spacer()
                    .frame(height: 56)
                        
                VStack {
                    Text("Fun Facts")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                    
                    Text("A colorless, transparent, odourless liquid that forms the seas, lakes, rivers, and rain and is the basis of the fluids of living organisms.")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(facts) { fact in
                            GeometryReader { geo in
                                Text(fact.name)
                                    .font(.system(.largeTitle, design: .rounded))
                                    .bold()
                                    .foregroundColor(Color.white)
                                    .tracking(0.37)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 289)
                                    .frame(width: 321, height: 375)
                                    .background(fact.color)
                                    .shadow(color: fact.color.opacity(0.25), radius: 60, x: 0, y: 30)
                                    .cornerRadius(30)
                                    .rotation3DEffect(Angle(degrees: Double(geo.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10.0, z: 0))
                            }
                            .frame(width: 321, height: 375)
                        }
                    }
                }
                HStack {
                    Label("Swipe to view more", systemImage:  "arrow.left")
                    Label(" ", systemImage: "arrow.right")
                }
                .padding()
                .foregroundColor(.white)
                .onReceive(timer) { time in
                    scaleAnimating.toggle()
                }
                .scaleEffect(x: scaleAnimating ? 1.0 : 1.1, y: scaleAnimating ? 1.0 : 1.5, anchor: .center)
                .animation(.easeIn)

                
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(
                VStack {
                    Spacer()
                    ZStack {
                        Wave(yOffset: changeWave ? 0.7 : -0.7)
                            .fill(Color(.systemTeal))
                            .frame(height: changeWave ? 406 : 150)
                            .shadow(radius: 4)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                        
                        Wave(yOffset: changeWave ? -0.5 : 0.5)
                            .fill(Color(.systemTeal))
                            .opacity(0.8)
                            .frame(height: changeWave ? 359.0 : 130)
                            .shadow(radius: 4)
                            .scaleEffect(x: 1.2, y: 1.2, anchor: .center)
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                            .onAppear { changeWave.toggle() }
                    }
                    .rotationEffect(.degrees(180))
                    .offset(y: 30)
                }
            )
        }
    }
    
    private func calculateWidth() -> CGFloat {
        let screen = 375 - 20
        
        let width = screen - (2 * 30)
        
        return CGFloat(width)
    }
}
