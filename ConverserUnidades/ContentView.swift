//
//  ContentView.swift
//  ConverserUnidades
//
//  Created by Gabriel Bruno Meira on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    
//    init(){
//        UIApplication.shared.isIdleTimerDisabled = false
//    }
    
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let units = ["Quilômetros", "Hectômetro", "Decâmetro", "Metro", "Decímetro", "Centímetro", "Milímetro"]
    
    var convertedValue: Double {
        let inputValue = Double(inputValue) ?? 0
        let numeroMilhao = 1000000.0
        let numeroCemMil = 100000.0
        let numeroDezMil = 10000.0
        let numeroMil = 1000.0
        let numeroCem = 100.0
        let numeroDez = 10.0
        
        switch (inputUnit, outputUnit) {
            
            // Quilômetro para outras unidades
            case (0, 1):
                return inputValue * numeroDez
            case (0, 2):
                return inputValue * numeroCem
            case (0, 3):
                return inputValue * numeroMil
            case (0, 4):
                return inputValue * numeroDezMil
            case (0, 5):
                return inputValue * numeroCemMil
            case (0, 6):
                return inputValue * numeroMilhao
            
            // Outras unidades para Quilômetro
            case (6, 0):
                return inputValue / numeroMilhao
            case (5, 0):
                return inputValue / numeroCemMil
            case (4, 0):
                return inputValue / numeroDezMil
            case (3, 0):
                return inputValue / numeroMil
            case (2, 0):
                return inputValue / numeroCem
            case (1, 0):
                return inputValue / numeroDez
            default:
                return inputValue
        }
    }
    
    var body: some View {
        VStack {
            Text("CONVERSOR DE UNIDADES")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()
                .padding()
            
            TextField("Digite o valor", text: $inputValue)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Categoria de conversão \nFazer a lógida")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
            
            
            HStack(alignment: .center) {
                Picker("Unidade de Origem", selection: $inputUnit) {
                    ForEach(0..<units.count, id: \.self) {
                        Text(self.units[$0])
                    }
                }
                .pickerStyle(.automatic)
                .padding()
                
                Text("para")
                
                Picker("Unidade de Destino", selection: $outputUnit) {
                    ForEach(0..<units.count, id: \.self) {
                        Text(self.units[$0])
                    }
                }
                .pickerStyle(.automatic)
                .padding()
            }
            
            Text("Resultado: \(convertedValue, specifier: "%.6f")") // Deixar sem número até o resultado ser pedido #FAZER
                .font(.title)
                .padding()
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
