//
//  ContentView.swift
//  Calculator
//
//  Created by Tomas Sanni on 7/30/22.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonTextColor: Color {
        switch self {
            case .add, .subtract, .multiply, .divide, .equal:
                return .blue
            case .clear, .negative, .percent:
            return .blue
            default:
            return .white
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}


//Environoment Object
class GlobalEnvironment: ObservableObject {
    @Published var display = "0"
    @Published var currentOperation: Operation = .none
    var runningNumber = 0

    func receiveInput(calculatorButton: CalcButton) {
//        self.display = calculatorButton.rawValue
        
        switch calculatorButton {
            
            //Operation cases
            case .add, .subtract, .multiply, .divide, .equal:
                if calculatorButton == .add {
                    self.currentOperation = .add
                    self.runningNumber = Int(self.display) ?? 0
                } else if calculatorButton == .subtract {
                    self.currentOperation = .subtract
                    self.runningNumber = Int(self.display) ?? 0

                } else if calculatorButton == .multiply {
                    self.currentOperation = .multiply
                    self.runningNumber = Int(self.display) ?? 0

                } else if calculatorButton == .divide {
                    self.currentOperation = .divide
                    self.runningNumber = Int(self.display) ?? 0

                } else if calculatorButton == .equal {
                    let runningValue = self.runningNumber
                    let currentValue = Int(self.display) ?? 0
                    switch self.currentOperation {
                        case .add: self.display = "\(runningValue + currentValue)"
                        case .subtract: self.display = "\(runningValue - currentValue)"
                        case .multiply: self.display = "\(runningValue * currentValue)"
                        case .divide: self.display = "\(runningValue / currentValue)"
                        case .none:
                            break
                    }
                }
                
                if calculatorButton != .equal {
                    self.display = "0"
                }
            //Clear button case
            case .clear:
                self.display = "0"
                break
            
            //Button, negative, and percent case
            case .decimal, .negative, .percent:
                break
            
            //All numbers case
            default:
                let number = calculatorButton.rawValue
                if self.display == "0" {
                    self.display = number
                } else {
                    self.display = "\(self.display)\(number)"
                }
        }
    }
}




struct ContentView: View {
    
//    @State var currentOperation: Operation = .none
    @StateObject var env = GlobalEnvironment()
    @State private var showSheet = false
    
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]

    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color(red: 0.151, green: 0.24, blue: 0.325)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 12) {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(env.display)
                            .foregroundColor(.white)
                            .font(.system(size: 72))
                    }
                    .padding()
                    
                    Button {
                        showSheet = true
                    } label: {
                        Text("Converter")
                            .padding()
                            .foregroundColor(.white)
                    }
                }

                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            
                            ExtractedView(button: button)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSheet) { UnitConverterView() }
        .environmentObject(env)
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
        ContentView()
            .previewDevice("iPod touch (7th generation)")
    }
}

struct ExtractedView: View {
    
    var button: CalcButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button {
            env.receiveInput(calculatorButton: button)
            
        } label: {
            
            if button.rawValue == "=" {
                Text(button.rawValue)
                    .font(.system(size: 32))
                    .frame(width: buttonWidth(item: button), height: buttonHeight())
                    .foregroundColor(button.buttonTextColor)
                    .background(Color.teal)
                    .cornerRadius(40)
            } else if button.rawValue == "AC" {
                Text(button.rawValue)
                    .font(.system(size: 32))
                    .frame(width: buttonWidth(item: button), height: buttonHeight())
                    .foregroundColor(.red)
    //                .background(button.buttonTextColor)
                    .cornerRadius(40)
            } else {
                Text(button.rawValue)
                    .font(.system(size: 32))
                    .frame(width: buttonWidth(item: button), height: buttonHeight())
                    .foregroundColor(button.buttonTextColor)
    //                .background(button.buttonTextColor)
                    .cornerRadius(40)
            }
            

        }
    }
    
    
    
    private func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2

        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4

    }
}
