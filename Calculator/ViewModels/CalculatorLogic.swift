//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Tomas Sanni on 8/1/22.
//

import Foundation

class CalculatorLogic: ObservableObject {
    
    @Published var number: Double?
    @Published var value = "0"
    @Published var typingDone = false
    var test: String? = "+"
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    func setNumber(_ number: Double) {
        self.number = number
    }
    
    func calculate(symbol: String) -> Double? {
       
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
    
    
    
    
    private var resultValue: Double
    {
        get
        {
            guard let number = Double(value) else //advanced optional.
            {
                fatalError("Cannot convert result label text to a Double.")
            }
            
            return number
        }
        set
        {
            value = String(newValue)
        }
    }
    
    
    
    func didTap(button: CalcButton) {
       switch button {
       case .equal, .add, .subtract, .multiply, .divide, .percent, .negative:
           typingDone = true
           
           setNumber(resultValue)
           
          

               if let result = calculate(symbol: button.rawValue)
               {
                   print("didtap")

                   resultValue = result
               }
               
           
           
       default:
           //if the number button's title is not nil
           
               //if typingDone is true, set numValue to the resultLabel text
               //numButton is pressed, typingDone is now false
               if typingDone == true
               {
                   self.value = button.rawValue
                   typingDone = false
               }
               //now typingDone is false, append text
               else
               {
                   
                   if button.rawValue == "."
                   {
                       
                       
                       let isInt = floor(resultValue) == resultValue
                       
                       if !isInt
                       {
                           return
                       }
                   }
                   
                   value = value + button.rawValue
               }
           
           
       

           
     

           if let result = calculate(symbol: button.rawValue)
               {
                   
                   resultValue = result
               }
               
           
           
       }
   }
    
}
