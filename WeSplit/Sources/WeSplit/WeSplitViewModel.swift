
import Foundation
import SwiftUI

struct WeSplitViewModel {
    var checkAmount = ""
//    var numberOfPeople = 2
    var numberOfPeople: String = "2"
    var tipPercentage = 2
    var tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipAmount = orderAmount * tipSelection
        let totalAmount = tipAmount + orderAmount
        return totalAmount
    }
    
    var totalPerPerson: LocalizedStringKey {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totalAmount / peopleCount
        
        return "$ \(amountPerPerson, specifier: "%.2f")"
    }
    
    var total: LocalizedStringKey {
        "$ \(totalAmount, specifier: "%.2f")"
    }
}
