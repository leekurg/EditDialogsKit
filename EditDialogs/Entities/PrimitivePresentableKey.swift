//
//  PrimitivePresentableKey.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

struct PrimitivePresentableKey<T: Hashable, Value: PrimitiveValue>: Identifiable {
    let id: String
    let title: String
    let description: String?
    let value: Value
    
    init(id: String, title: String, description: String? = nil, value: Value) {
        self.id = id
        self.title = title
        self.description = description
        self.value = value
    }
}
