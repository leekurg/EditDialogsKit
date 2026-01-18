//
//  EditIntView.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

import SwiftUI

struct EditIntView: View {
    let value: Int
    @Binding var isValid: Bool
    let onChange: (Int) -> Void
    
    @FocusState var isFocused: Bool
    @State private var text: String
    
    init(value: Int, isValid: Binding<Bool>, onChange: @escaping (Int) -> Void ) {
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
    
    private func validate(_ newValue: String) -> Int? {
        let convertedValue = Int(newValue)
        
        withAnimation(.spring) {
            isValid = convertedValue != nil
        }
        
        return convertedValue
    }
}

fileprivate struct ProxyView: View {
    @State var isValid = true
    
    var body: some View {
        EditIntView(value: 11, isValid: $isValid) { newValue in
            print("new value: \(newValue)")
        }
    }
}

#Preview {
    ProxyView()
        .preferredColorScheme(.dark)
}
