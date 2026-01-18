//
//  Primitive.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

public enum Primitive: Equatable, PrimitiveValue {
    case bool(_ value: Bool)
    case int(_ value: Int)
    case double(_ value: Double)
    case string(_ value: String)
    
    public var value: Any {
        switch self {
        case .bool(let value): value
        case .int(let value): value
        case .double(let value): value
        case .string(let value): value
        }
    }
}
