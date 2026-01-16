//
//  EditBoolView.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

import SwiftUI

struct EditBoolView: View {
    let value: Bool
    let onChange: (Bool) -> Void
    
    @State private var stateValue: Bool
    
    init(value: Bool, onChange: @escaping (Bool) -> Void ) {
        self.value = value
        self.onChange = onChange
        
        self._stateValue = State(wrappedValue: value)
    }
    
    var body: some View {
        Toggle(isOn: $stateValue, label: {})
            .labelsHidden()
            .scaleEffect(2)
            .onChange(of: value) { newValue in
                stateValue = newValue
            }
            .onChange(of: stateValue) { newValue in
                onChange(newValue)
            }
    }
}

fileprivate struct ProxyView: View {
    @State var value = true
    
    var body: some View {
        EditBoolView(value: value) { newValue in
            value = newValue
            print("new value: \(newValue)")
        }
    }
}

#Preview {
    ProxyView()
        .preferredColorScheme(.dark)
}
