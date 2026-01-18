//
//  PrimitivePresentableKey.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

public struct PrimitivePresentableKey<T: Hashable, Value: PrimitiveValue>: Identifiable {
    public let id: String
    public let title: String
    public let description: String?
    public let value: Value
    
    public init(id: String, title: String, description: String? = nil, value: Value) {
        self.id = id
        self.title = title
        self.description = description
        self.value = value
    }
}
