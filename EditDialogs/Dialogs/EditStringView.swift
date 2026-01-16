//
//  EditStringView.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

import SwiftUI

struct EditStringView: View {
    let value: String
    let onChange: (String) -> Void
    
    @State private var text: String
    @FocusState private var isFocused: Bool
    
    init(value: String, onChange: @escaping (String) -> Void ) {
        self.value = value
        self.onChange = onChange
        
        self._text = State(wrappedValue: value)
    }
    
    var body: some View {
        TextField(
            "Edit string",
            text: $text,
            prompt: Text(verbatim: "Enter string..."),
            axis: .vertical
        )
        .focused($isFocused)
        .font(.system(size: 25, weight: .semibold, design: .rounded))
        .multilineTextAlignment(.center)
        .lineLimit(5)
        .padding()
        .onChange(of: value) { newValue in
            text = newValue
        }
        .onChange(of: text) { newValue in
            onChange(newValue)
        }
        .onAppear { isFocused = true }
    }
}

fileprivate struct ProxyView: View {
    @State var value = "hello world"
    
    var body: some View {
        EditStringView(value: value) { newValue in
            value = newValue
            print("new value: \(newValue)")
        }
    }
}

#Preview {
    ProxyView()
        .preferredColorScheme(.dark)
}
