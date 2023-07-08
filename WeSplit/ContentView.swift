//
//  ContentView.swift
//  WeSplit
//
//  Created by Danielle Lewis on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var noTip: Bool {
        if (tipPercentage == 0) {
            return true
        }
        return false
    }
    
    var grandTotal: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
    
    let formatForCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    TextField("Amount", value: $checkAmount, format: formatForCurrency)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    
                } header: {
                    Text("How much is the bill?")
                }
                
                Section {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(grandTotal, format: formatForCurrency)
                        .foregroundColor(noTip ? .red : .blue)
                } header: {
                    Text("Grand total")
                }
                
                Section {
                    Text(totalPerPerson, format: formatForCurrency)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

