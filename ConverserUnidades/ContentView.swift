//
//  ContentView.swift
//  ConverserUnidades
//
//  Created by Gabriel Bruno Meira on 04/10/23.
//

// Comentário para Testar a Branch para inserir novas conversões.
// Importante fazer uma pesquisa de quais conversões são mais utilizadas.


import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    @State private var selectedCategoryIndex = 0
    @State private var selectedSubcategoryInput = 0
    @State private var selectedSubcategoryOutput = 1
    @FocusState private var amountIsFocused: Bool
    
    let categories = ["Comprimento", "Massa", "Volume"] // CASO EU AUMENTE AS CATEGORIAS ONDE PRECISSASE DE OUTRAS FORMULAS E NÃO SÓ * E /
    let subcategories = [
        ["Quilômetros", "Hectômetro", "Decâmetro", "Metro", "Decímetro", "Centímetro", "Milímetro"],
        ["Quilograma", "Hectograma", "Decagrama", "Grama", "Decigrama", "Centigrama", "Miligrama"],
        ["Quilolitro", "Hectolitro", "Decalitro", "Litro", "Decilitro", "Centilitro", "Militro"]
    ]
    
    var convertedValue: Double {
        let inputValue = Double(inputValue.replacingOccurrences(of: ",", with: ".")) ?? 0
        let numeroMilhao = 1000000.0
        let numeroCemMil = 100000.0
        let numeroDezMil = 10000.0
        let numeroMil = 1000.0
        let numeroCem = 100.0
        let numeroDez = 10.0
        
        switch (selectedSubcategoryInput, selectedSubcategoryOutput) { // DA PARA DIMINUIR ESSES CASES OU FAZER DE OUTRA FORMA?
            
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
            
            // Unidade Hectômetro para outra
        case (1, 0):
            return inputValue / numeroDez
        case (1, 2):
            return inputValue * numeroDez
        case (1, 3):
            return inputValue * numeroCem
        case (1, 4):
            return inputValue * numeroMil
        case (1, 5):
            return inputValue * numeroDezMil
        case (1, 6):
            return inputValue * numeroCemMil
            
            // Unidade Decâmetro para outra
        case (2, 0):
            return inputValue / numeroCem
        case (2, 1):
            return inputValue / numeroDez
        case (2, 3):
            return inputValue * numeroDez
        case (2, 4):
            return inputValue * numeroCem
        case (2, 5):
            return inputValue * numeroMil
        case (2, 6):
            return inputValue * numeroDezMil
            
            // Unidade Metros para outra
        case (3, 0):
            return inputValue / numeroMil
        case (3, 1):
            return inputValue / numeroCem
        case (3, 2):
            return inputValue / numeroDez
        case (3, 4):
            return inputValue * numeroDez
        case (3, 5):
            return inputValue * numeroCem
        case (3, 6):
            return inputValue * numeroMil
            
            // Unidade Decímetro para outra
        case (4, 0):
            return inputValue / numeroDezMil
        case (4, 1):
            return inputValue / numeroMil
        case (4, 2):
            return inputValue / numeroCem
        case (4, 3):
            return inputValue / numeroDez
        case (4, 5):
            return inputValue * numeroDez
        case (4, 6):
            return inputValue * numeroCem
            
            // Unidade Centímetro para outra
        case (5, 0):
            return inputValue / numeroCemMil
        case (5, 1):
            return inputValue / numeroDezMil
        case (5, 2):
            return inputValue / numeroMil
        case (5, 3):
            return inputValue / numeroCem
        case (5, 4):
            return inputValue / numeroDez
        case (5, 6):
            return inputValue * numeroDez
            
            // Unidade Miímetro para outra
        case (6, 0):
            return inputValue / numeroMilhao
        case (6, 1):
            return inputValue / numeroCemMil
        case (6, 2):
            return inputValue / numeroDezMil
        case (6, 3):
            return inputValue / numeroMil
        case (6, 4):
            return inputValue / numeroCem
        case (6, 5):
            return inputValue / numeroDez
            
        default:
            return inputValue
        }
    }
    
    func formatWithoutZeros(_ value: Double) -> String {
        print(value)
//        let formattedValue = String(value).replacingOccurrences(of: ",", with: ".")
        let formattedString = String(format: "0%.6f", value)
        
        let trimmedString = formattedString.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        
        if trimmedString.last == "." {
            return String(trimmedString.dropLast())
        } else {
            return "0" + trimmedString
        }
        
    }
    
    var body: some View {
        
        let conversaoFinal = formatWithoutZeros(convertedValue)
        
        VStack {
            
            Text("CONVERSOR DE UNIDADES")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()
                .padding()
            
            Text("Selecione uma categoria:")
            
            Picker("Categoria", selection: $selectedCategoryIndex) {
                ForEach(0..<categories.count, id: \.self) { index in
                    Text(categories[index])
                        .foregroundColor(Color.orange)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Text("Selecione uma subcategoria:")
                .padding(.top, 20)
            
            HStack(alignment: .center) {
                
                Picker("Subcategoria", selection: $selectedSubcategoryInput) {
                    ForEach(0..<subcategories[selectedCategoryIndex].count, id: \.self) { index in
                        Text(subcategories[selectedCategoryIndex][index])
                    }
                }
                .pickerStyle(.automatic)
                .tint(Color.orange)
                .padding()
                
                Text("para")
                
                Picker("Unidade de Destino", selection: $selectedSubcategoryOutput) {
                    ForEach(0..<subcategories[selectedCategoryIndex].count, id: \.self) { index in
                        Text(subcategories[selectedCategoryIndex][index])
                    }
                }
                .pickerStyle(.automatic)
                .tint(Color.orange)
                .padding()
            }
            
            TextField("Digite o valor", text: $inputValue)
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                
                Text("RESULTADO: \(conversaoFinal)")
                    .font(.title3)
                    .bold()
                    .padding()
                
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = conversaoFinal
                }){
                    Image(systemName: "doc.on.doc")
                }
                .tint(Color.orange)
                
            }
            .toolbar{
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
    
#Preview {
    ContentView()
}
