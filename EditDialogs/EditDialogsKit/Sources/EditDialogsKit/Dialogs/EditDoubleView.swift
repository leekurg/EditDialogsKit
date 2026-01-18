//
//  EditDoubleView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

struct EditDoubleView: View {
    let value: Double
    @Binding var isValid: Bool
    let onChange: (Double) -> Void
    
    @FocusState var isFocused: Bool
    @State private var text: String
    
    init(value: Double, isValid: Binding<Bool>, onChange: @escaping (Double) -> Void ) {
        self.value = value
        self._isValid = isValid
        self.onChange = onChange
        self._text = State(wrappedValue: "\(value)")
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text(verbatim: "Enter a number..."))
                .padding()
                .multilineTextAlignment(.center)
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .focused($isFocused)
                .foregroundStyle(isValid ? .primary : Color.red)
        }
        .keyboardType(.numberPad)
        .onChange(of: text) { newText in
            let value = validate(newText)
            
            if let value {
                onChange(value)
            }
        }
        .onChange(of: value) { newValue in
            text = "\(newValue)"
        }
        .onAppear { isFocused = true }
    }
    
    private func validate(_ newValue: String) -> Double? {
        let convertedValue = Double(newValue)
        
        withAnimation(.spring) {
            isValid = convertedValue != nil
        }
        
        return convertedValue
    }
}

fileprivate struct ProxyView: View {
    @State var isValid = true
    
    var body: some View {
        EditDoubleView(value: 3.14, isValid: $isValid) { newValue in
            print("new value: \(newValue)")
        }
    }
}

#Preview {
    ProxyView()
        .preferredColorScheme(.dark)
}
