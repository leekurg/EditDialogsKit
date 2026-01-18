//
//  StringFormatStyle.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

public enum StringFormatStyle: Sendable {
    case firstCapitalized
    case uppercased
    case lowercased
    case transform(_ transform: @Sendable (String) -> String)
    
    public static let `default`: StringFormatStyle = .transform({ $0 })
    
    public func format(_ string: String) -> String {
        switch self {
        case .firstCapitalized:
            string.prefix(1).uppercased() + string.dropFirst()
        case .uppercased:
            string.uppercased()
        case .lowercased:
            string.lowercased()
        case let .transform(transform):
            transform(string)
        }
    }
}
