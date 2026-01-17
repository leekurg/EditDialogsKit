//
//  Environment.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

extension EnvironmentValues {
    var primitiveBoolFormat: BoolFormatStyle {
        get { self[BoolFormatKey.self] }
        set { self[BoolFormatKey.self] = newValue }
    }
    
    var primitiveIntFormat: any FormatStyle<Int, String> {
        get { self[IntFormatKey.self] }
        set { self[IntFormatKey.self] = newValue }
    }
    
    var primitiveStringFormat: StringFormatStyle {
        get { self[StringFormatKey.self] }
        set { self[StringFormatKey.self] = newValue }
    }
    
    var primitiveDoubleFormat: any FormatStyle<Double, String> {
        get { self[DoubleFormatKey.self] }
        set { self[DoubleFormatKey.self] = newValue }
    }
}

fileprivate struct BoolFormatKey: EnvironmentKey {
    static let defaultValue: BoolFormatStyle = .default
}

fileprivate struct IntFormatKey: EnvironmentKey {
    static let defaultValue: any FormatStyle<Int, String> = .number
}

fileprivate struct StringFormatKey: EnvironmentKey {
    static let defaultValue: StringFormatStyle = .default
}

fileprivate struct DoubleFormatKey: EnvironmentKey {
    static let defaultValue: any FormatStyle<Double, String> = .number.precision(.fractionLength(2))
}

extension View {
    func primitiveFormatBool(_ format: BoolFormatStyle? = nil) -> some View {
        environment(\.primitiveBoolFormat, format ?? .default)
    }
    
    func primitiveFormatInt(_ format: (any FormatStyle<Int, String>)? = nil) -> some View {
        environment(\.primitiveIntFormat, format ?? IntFormatKey.defaultValue)
    }
    
    func primitiveFormatString(_ format: StringFormatStyle? = nil) -> some View {
        environment(\.primitiveStringFormat, format ?? .default)
    }
    
    func primitiveFormatDouble(_ format: (any FormatStyle<Double, String>)?) -> some View {
        environment(\.primitiveDoubleFormat, format ?? DoubleFormatKey.defaultValue)
    }
}
