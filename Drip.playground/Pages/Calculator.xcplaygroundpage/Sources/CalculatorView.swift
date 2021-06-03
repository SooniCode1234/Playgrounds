import SwiftUI

public struct CalculatorView: View {
    @State private var weight = ""
    @State private var isPulsating = false
    @State private var weightAmount: Double = 0
    @State var scaleAnimating = false
    @State private var changeWave = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresenting = false
    @State private var isWeightFieldFocused: Bool = false
    
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    public init() { }
    
    private func calculateWaterAmountDaily(for weight: Double) -> Double {
        let ounces = weight * 2/3
        
        let ml = ounces * 29.574
        
        return ml
    }
    
    public var body: some View {
        ZStack {
            LinearGradient(gradient: Color.drBackgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: 56)
                
                Text("Calculator")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                
                if weightAmount == 0 {
                    ScaleShape(animating: scaleAnimating)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .frame(width: 300, height: 300)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                self.isPresenting = true
                            } }
                        .onReceive(timer) { time in
                            if isPresenting {
                                
                                scaleAnimating.toggle()
                            }
                        }
                    
                } else {
                    VStack(spacing: 10) {
                        Text("You need")
                            .foregroundColor(Color.white)
                            .tracking(0.36)
                            .multilineTextAlignment(.center)
                        
                        Text("\(Int(weightAmount.rounded())) mL")
                            .font(.system(.title3, design: .rounded))
                            .bold()
                            .foregroundColor(Color.white)
                            .tracking(0.37)
                            .multilineTextAlignment(.center)
                        
                        Text("Daily")
                            .foregroundColor(Color.white)
                            .tracking(0.36)
                            .multilineTextAlignment(.center)
                        
                    }
                    .font(Font.system(.title, design: .rounded).weight(.medium))
                    .frame(width: 220, height: 220)
                    .background(
                        ZStack {
                            ZStack {
                                Circle()
                                    .fill(Color(#colorLiteral(red: 0.3450980484485626, green: 0.33725491166114807, blue: 0.8392156958580017, alpha: 0.5)))
                                
                                Circle()
                                    .strokeBorder(Color(#colorLiteral(red: 0.3450980484485626, green: 0.33725491166114807, blue: 0.8392156958580017, alpha: 0.5)), lineWidth: 10)
                            }
                            .frame(width: isPulsating ? 250 : 200, height: isPulsating ? 250 : 200)
                            
                            ZStack {
                                Circle()
                                    .fill(Color.drPurple)
                                
                                Circle()
                                    .strokeBorder(Color.drPurple, lineWidth: 10)
                            }
                            .frame(width: 200, height: 200)
                        }
                        .animation(
                            Animation
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: true)
                        )
                    )
                    .animation(.spring())
                    .onAppear { isPulsating = true }
                    .padding(.top, 50)
                }
                
                Spacer()
                
                VStack(spacing: 24) {
                    FocusableTextField(text: $weight,
                                       isFirstResponder: $isWeightFieldFocused,
                                       placeholder: "Enter your weight (lbs)")
                    { textfield in
                        weightAmount = calculateWaterAmountDaily(for: Double(weight) ?? 0)
                        timer.upstream.connect().cancel()
                        self.isWeightFieldFocused = false
                    }
                    .font(Font.system(.callout, design: .rounded).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(#colorLiteral(red: 0.522352933883667, green: 0.5484705567359924, blue: 0.5803921818733215, alpha: 1)), lineWidth: 1))
                    .padding(.horizontal, 20)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    DRButton(title: "Calculate", backgroundColor: .blue) {
                        weightAmount = calculateWaterAmountDaily(for: Double(weight) ?? 0)
                        timer.upstream.connect().cancel()
                        self.isWeightFieldFocused = false
                    }
                    .padding(.horizontal, 16)
                }
                .onAppear {
                    self.isWeightFieldFocused = true
                }
                
                Spacer()
                    .frame(height: 59)
            }
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
        .onTapGesture {
            isWeightFieldFocused = false
        }
    }
}

public func preview() -> UIViewController {
    let parent = UIViewController()
    let child = UIHostingController(rootView: CalculatorView())

    child.view.translatesAutoresizingMaskIntoConstraints = false
    child.view.frame = parent.view.bounds



    // First, add the view of the child to the view of the parent
    parent.view.addSubview(child.view)
    // Then, add the child to the parent
    parent.addChild(child)

    parent.preferredContentSize = parent.view.frame.size
    
    return parent
}
