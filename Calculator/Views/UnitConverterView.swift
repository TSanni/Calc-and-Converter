//
//  UnitConverterView.swift
//  Calculator
//
//  Created by Tomas Sanni on 8/10/22.
//

import SwiftUI

enum LengthChoices: String {
    case millimeters = "Millimeters (mm)"
    case centimeters = "Centimeters (cm)"
    case meters = "Meters (m)"
    case kilometers = "Kilometers (km)"
    case inches = "Inches (in)"
    case feet = "Feet (ft)"
    case yards = "Yards (yd)"
    case miles = "Miles (mi)"
    case nauticalMiles = "Nautical Miles (NM)"
}


enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "."
    case backspace = "<-"
}




struct UnitConverterView: View {

    @StateObject var units = Units()
    @State var unitType = LengthChoices.millimeters
    @State var unitType2 = LengthChoices.millimeters
    let screenwidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let buttons: [[Buttons]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.zero, .decimal, .backspace]
    ]
    
    func menuHandle1(unit: LengthChoices) {
        switch unit {
        case .millimeters:
            unitType = .millimeters
            units.lengthChoice = .millimeters
        case .centimeters:
            unitType = .centimeters
            units.lengthChoice = .centimeters
        case .meters:
            unitType = .meters
            units.lengthChoice = .meters
        case .kilometers:
            unitType = .kilometers
            units.lengthChoice = .kilometers
        case .inches:
            unitType = .inches
            units.lengthChoice = .inches
        case .feet:
            unitType = .feet
            units.lengthChoice = .feet
        case .yards:
            unitType = .yards
            units.lengthChoice = .yards
        case .miles:
            unitType = .miles
            units.lengthChoice = .miles
        case .nauticalMiles:
            unitType = .nauticalMiles
            units.lengthChoice = .nauticalMiles
        }
    }
    
    func menuHandle2(unit: LengthChoices) {
        switch unit {
        case .millimeters:
            unitType2 = .millimeters
            units.lengthChoice2 = .millimeters
        case .centimeters:
            unitType2 = .centimeters
            units.lengthChoice2 = .centimeters
        case .meters:
            unitType2 = .meters
            units.lengthChoice2 = .meters
        case .kilometers:
            unitType2 = .kilometers
            units.lengthChoice2 = .kilometers
        case .inches:
            unitType2 = .inches
            units.lengthChoice2 = .inches
        case .feet:
            unitType2 = .feet
            units.lengthChoice2 = .feet
        case .yards:
            unitType2 = .yards
            units.lengthChoice2 = .yards
        case .miles:
            unitType2 = .miles
            units.lengthChoice2 = .miles
        case .nauticalMiles:
            unitType2 = .nauticalMiles
            units.lengthChoice2 = .nauticalMiles
        }
    }
    
    
    
    
    var body: some View {
        ZStack {
           
            Color(red: 0.151, green: 0.24, blue: 0.325)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                //Top converter
                VStack {
                    HStack {
                        ZStack { //ZStack to circumvent strange menu title change
                            Text(unitType.rawValue)
                                .font(.title3)
                            
                            Menu(unitType.rawValue) {
                                Button(LengthChoices.millimeters.rawValue) { menuHandle1(unit: .millimeters) }
                                Button(LengthChoices.centimeters.rawValue) { menuHandle1(unit: .centimeters) }
                                Button(LengthChoices.meters.rawValue) { menuHandle1(unit: .meters) }
                                Button(LengthChoices.kilometers.rawValue) { menuHandle1(unit: .kilometers) }
                                Button(LengthChoices.inches.rawValue) { menuHandle1(unit: .inches)}
                                Button(LengthChoices.feet.rawValue) { menuHandle1(unit: .feet) }
                                Button(LengthChoices.yards.rawValue) { menuHandle1(unit: .yards) }
                                Button(LengthChoices.miles.rawValue) { menuHandle1(unit: .miles) }
                                Button(LengthChoices.nauticalMiles.rawValue) { menuHandle1(unit: .nauticalMiles)}
                            }
                            .foregroundColor(.clear)
                        }

                        

                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
//                        Text("units.typedInputValue")
//                            .frame(height: 50)
//                            .frame(maxWidth: .infinity)
                        TextField("Enter", text: $units.typedInputValue)
                            .multilineTextAlignment(.trailing)
                            .disabled(true)
                    }
                    
                }
                
                Divider()
                
                //Bottom converter
                VStack {
                    HStack {
                        ZStack {
                            Text(unitType2.rawValue)
                                .font(.title3)

                            Menu(unitType2.rawValue) {
                                Button(LengthChoices.millimeters.rawValue) { menuHandle2(unit: .millimeters) }
                                Button(LengthChoices.centimeters.rawValue) { menuHandle2(unit: .centimeters) }
                                Button(LengthChoices.meters.rawValue) { menuHandle2(unit: .meters) }
                                Button(LengthChoices.kilometers.rawValue) { menuHandle2(unit: .kilometers) }
                                Button(LengthChoices.inches.rawValue) { menuHandle2(unit: .inches)}
                                Button(LengthChoices.feet.rawValue) { menuHandle2(unit: .feet) }
                                Button(LengthChoices.yards.rawValue) { menuHandle2(unit: .yards) }
                                Button(LengthChoices.miles.rawValue) { menuHandle2(unit: .miles) }
                                Button(LengthChoices.nauticalMiles.rawValue) { menuHandle2(unit: .nauticalMiles)}
                            }

                        .foregroundColor(.clear)
                        }

                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                            Text(units.computedAnswer)
                                .multilineTextAlignment(.trailing)

                    }
                }
                
                Divider()
                
                Spacer()
                
                //Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            ButtonView(button: button)

                        }
                    }
                    
                }
                
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .environmentObject(units)
        
    }
    
}
    struct UnitConverterView_Previews: PreviewProvider {
        static var previews: some View {
            UnitConverterView()
                .previewDevice("iPhone 13 Pro Max")
            
            UnitConverterView()
                .previewDevice("iPod touch (7th generation)")
        }
    }

struct ButtonView: View {
    @EnvironmentObject var units: Units
    let button: Buttons
    
    let screenwidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        Button {
            units.handleButtonInput(button: button)
        } label: {
            if button.rawValue == "<-" {
                Image(systemName: "delete.backward.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .frame(width: (screenwidth - (3*12)) / 3, height: (screenwidth - (3*12)) / 3)

            } else {
                Text(button.rawValue)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .frame(width: (screenwidth - (3*12)) / 3, height: (screenwidth - (3*12)) / 3)
            }
            

        }
    }
}
