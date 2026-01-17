//
//  StringFormatStyle.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

enum StringFormatStyle {
    case firstCapitalized
    case uppercased
    case lowercased
    case transform(_ transform: (String) -> String)
    
    static let `default`: StringFormatStyle = .transform({ $0 })
    
    func format(_ string: String) -> String {
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
