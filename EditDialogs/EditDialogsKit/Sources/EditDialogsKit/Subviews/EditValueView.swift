//
//  EditValueView.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

import SwiftUI

public struct EditValueView<T: Hashable>: View {
    let id: T
    let value: Primitive
    let onSave: (T, Primitive) -> Void
    
    @State var isValidToSave: Bool = true
    @State var newValue: Primitive?
    
    public init(id: T, value: Primitive, onSave: @escaping (T, Primitive) -> Void) {
        self.id = id
        self.value = value
        self.onSave = onSave
        
        self._newValue = State(initialValue: value)
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                switch value {
                case .bool(let value):
                    EditBoolView(value: value) { newValue in
                        self.newValue = .bool(newValue)
                    }
                    .navigationTitle(String("Editing boolean"))
                    .presentationDetents([.height(150)])
                    
                case .int(let value):
                    EditIntView(value: value, isValid: $isValidToSave) { newValue in
                        self.newValue = .int(newValue)
                    }
                    .navigationTitle(String("Editing integer"))
                    .presentationDetents([.height(150)])
                    
                case .string(let value):
                    EditStringView(value: value) { newValue in
                        self.newValue = .string(newValue)
                    }
                    .navigationTitle(String("Editing string"))
                    .presentationDetents([.height(200)])
                    
                case .double(let value):
                    EditDoubleView(value: value, isValid: $isValidToSave) { newValue in
                        self.newValue = .double(newValue)
                    }
                    .navigationTitle(String("Editing double"))
                    .presentationDetents([.height(150)])
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let newValue {
                            onSave(id, newValue)
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!isValidToSave)
                    .tint(isValidToSave ? .blue : .gray)
                    .id(isValidToSave)
                }
            }
        }
    }
}



#Preview("Edit value") {
//    EditValueView(id: "sample", value: .int(14)) { id, newValue in
//    EditValueView(id: "sample", value: .bool(true)) { id, newValue in
    EditValueView(id: "sample", value: .string("hello")) { id, newValue in
        print("new value for id \(id): \(newValue)")
    }
    .preferredColorScheme(.dark)
}
