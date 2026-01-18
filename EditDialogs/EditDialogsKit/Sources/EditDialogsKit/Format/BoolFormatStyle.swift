//
//  BoolFormatStyle.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

public enum BoolFormatStyle: @unchecked Sendable {
    case systemImage(true: String, false: String)
    case imageNamed(true: ImageSpec, false: ImageSpec)
    case localizableString(true: LocalizedStringKey, false: LocalizedStringKey)
    
    public static let `default`: Self = .systemImage(
        true: "checkmark.circle",
        false: "circle"
    )
    
    public static let trueFalse: Self = .localizableString(
        true: "true",
        false: "false"
    )
    
    public static let enabledDisabled: Self = .localizableString(
        true: "enabled",
        false: "disabled"
    )
}

public extension BoolFormatStyle {
    struct ImageSpec: ExpressibleByStringLiteral {
        let named: String
        let bundle: Bundle?
        
        init(named: String, bundle: Bundle? = nil) {
            self.named = named
            self.bundle = bundle
        }
        
        public static func named(_ name: String, bundle: Bundle? = nil) -> Self {
            Self(named: name, bundle: bundle)
        }
        
        public init(stringLiteral: String) {
            self.init(named: stringLiteral)
        }
    }
}
