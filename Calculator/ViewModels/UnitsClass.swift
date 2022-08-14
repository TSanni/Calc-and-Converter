//
//  UnitsClass.swift
//  Calculator
//
//  Created by Tomas Sanni on 8/14/22.
//

import Foundation

class Units: ObservableObject {
    @Published var typedInputValue = "" //change to inputValue later
    
    @Published var lengthChoice: LengthChoices = .millimeters
    @Published var lengthChoice2: LengthChoices = .millimeters
    
    init() {

    }
    
    func handleButtonInput(button: Buttons) {
        
        switch button {
        case .backspace:
            typedInputValue.popLast()
        default:
            typedInputValue.append(button.rawValue)
        }
        
    }
    

    var computedAnswer: String {
        
        var input = Measurement(value: 0, unit: UnitLength.millimeters)
        var output = String(describing: input.converted(to: UnitLength.millimeters))
        
        switch lengthChoice {
        case .millimeters:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.millimeters)
        case .centimeters:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.centimeters)
        case .meters:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.meters)
        case .kilometers:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.kilometers)
        case .inches:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.inches)
        case .feet:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.feet)
        case .yards:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.yards)
        case .miles:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.miles)
        case .nauticalMiles:
            input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.nauticalMiles)

        }
        
        
        switch lengthChoice2 {
        case .millimeters:
            output = String(describing: input.converted(to: UnitLength.millimeters))
        case .centimeters:
            output = String(describing: input.converted(to: UnitLength.centimeters))
        case .meters:
            output = String(describing: input.converted(to: UnitLength.meters))
        case .kilometers:
            output = String(describing: input.converted(to: UnitLength.kilometers))
        case .inches:
            output = String(describing: input.converted(to: UnitLength.inches))
        case .feet:
            output = String(describing: input.converted(to: UnitLength.feet))
        case .yards:
            output = String(describing: input.converted(to: UnitLength.yards))
        case .miles:
            output = String(describing: input.converted(to: UnitLength.miles))
        case .nauticalMiles:
            output = String(describing: input.converted(to: UnitLength.nauticalMiles))
        }

        return output
        
        
//        var ok = ""
//
//        let holderValue = input
//         ok = String(describing: holderValue.converted(to: UnitLength.centimeters))
//        return ok

    }

    
}
