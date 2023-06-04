//
//  ContentView.swift
//  ConversionCalculator
//
//  Created by Luke Kvamme on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var unitOne = "meters"
    @State private var valueOne = 1
    @State private var unitTwo = "feet"
    private let temperature = ["Celsius", "Fahrenheit", "Kelvin"]
    private let length = ["meters", "kilometers", "feet", "yards", "miles"]
    private let time = ["seconds", "minutes", "hours", "days"]
    private let volume = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    var convertedValue: Int {
        let from = unitOne
        let to = unitTwo
        var value = valueOne
        let meter = [1, length[0]] as [Any]
        let kilometer = [1_000, length[1]] as [Any]
        let foot = [3, length[2]] as [Any]
        let yard = [1, length[3]] as [Any]
        let mile = [1_610, length[4]] as [Any]
        
        let list = [meter, kilometer, foot, yard, mile]
        var inputVal = 0
        var outputVal = 0
        for _unit in list {
            if to == from {
                return value
            }
            else if from == _unit[1] as! String {
                inputVal = _unit[0] as! Int
            }
            else if to == _unit[1] as! String {
                outputVal = _unit[0] as! Int
            }
            else {
                outputVal = inputVal
            }
        }
        value = outputVal * (value * inputVal)
        
        return value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Length Unit", selection: $unitOne) {
                        ForEach(length, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Input Value", value: $valueOne, format: .number)
                } header: {
                    Text("Length Input")
                }
                
                Section {
                    Picker("Select Output Unit", selection: $unitTwo) {
                        ForEach(length, id: \.self) {
                            Text($0)
                        }
                    }
                    Text(convertedValue, format: .number)
                } header: {
                    Text("Length Output")
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
