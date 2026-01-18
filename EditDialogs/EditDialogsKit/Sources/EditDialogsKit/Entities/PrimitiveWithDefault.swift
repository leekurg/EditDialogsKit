//
//  PrimitiveWithDefault.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

import Foundation

public enum PrimitiveWithDefault: Equatable, PrimitiveValue {
    case bool(value: Bool, default: Bool)
    case int(value: Int, default: Int)
    case string(value: String, default: String)
    case double(value: Double, default: Double)
    
    public var isDefault: Bool {
        switch self {
        case .bool(let v, let d): v == d
        case .int(let v, let d): v == d
        case .string(let v, let d): v == d
        case .double(let v, let d): v == d
        }
    }
    
    public var primitive: Primitive {
        switch self {
        case .bool(let value, _): .bool(value)
        case .int(let value, _): .int(value)
        case .string(let value, _): .string(value)
        case .double(let value, _): .double(value)
        }
    }
    
    public var defaultPrimitive: Primitive {
        switch self {
        case .bool(_, let value): .bool(value)
        case .int(_, let value): .int(value)
        case .string(_, let value): .string(value)
        case .double(_, let value): .double(value)
        }
    }
}

// MARK: - Init
public extension PrimitiveWithDefault {
    static func bool(value v: Any, default d: Any) throws -> Self {
        guard let v = v as? Bool, let d = d as? Bool else { throw CastError() }
        
        return Self.bool(value: v, default: d)
    }
    
    static func int(value v: Any, default d: Any) throws -> Self {
        guard let v = v as? Int, let d = d as? Int else { throw CastError() }
        
        return Self.int(value: v, default: d)
    }
    
    static func string(value v: Any, default d: Any) throws -> Self {
        guard let v = v as? String, let d = d as? String else { throw CastError() }
        
        return Self.string(value: v, default: d)
    }
    
    static func double(value v: Any, default d: Any) throws -> Self {
        guard let v = v as? Double, let d = d as? Double else { throw CastError() }
        
        return Self.double(value: v, default: d)
    }
}

// MARK: - Value access
public extension PrimitiveWithDefault {
    var value: Any {
        switch self {
        case .bool(let value, _): value
        case .int(let value, _): value
        case .string(let value, _): value
        case .double(let value, _): value
        }
    }
    
    var `default`: Any {
        switch self {
        case .bool(_, let value): value
        case .int(_, let value): value
        case .string(_, let value): value
        case .double(_, let value): value
        }
    }
}

// MARK: - Error
public extension PrimitiveWithDefault {
    struct CastError: LocalizedError {
        public var errorDescription: String? = "Unable to cast target type"
    }
}

// MARK: Cast
public extension PrimitiveWithDefault {
    init(primitive: Primitive, default d: Any) throws {
        switch primitive {
        case .bool(let value): self = try .bool(value: value, default: d)
        case .int(let value): self = try .int(value: value, default: d)
        case .string(let value): self = try .string(value: value, default: d)
        case .double(let value): self = try .double(value: value, default: d)
        }
    }
}
