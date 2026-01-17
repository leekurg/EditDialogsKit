//
//  BoolFormatStyle.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

enum BoolFormatStyle {
    case systemImage(true: String, false: String)
    case imageResource(true: ImageResource, false: ImageResource)
    case localizableString(true: LocalizedStringKey, false: LocalizedStringKey)
    
    static let `default`: Self = .systemImage(
        true: "checkmark.circle",
        false: "circle"
    )
    
    static let trueFalse: Self = .localizableString(
        true: "true",
        false: "false"
    )
    
    static let enabledDisabled: Self = .localizableString(
        true: "enabled",
        false: "disabled"
    )
}
