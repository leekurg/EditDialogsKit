//
//  PrimitiveView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

struct PrimitiveView: View {
    let value: any PrimitiveValue
    
    var body: some View {
        Group {
            switch value.value {
            case let bool as Bool:
                Image(systemName: bool ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
            case let int as Int:
                Text(verbatim: "\(int)")
                
            case let string as String:
                Text(verbatim: "\(string)")
                
            case let double as Double:
                Text(verbatim: String(format: "%.2f", double))
                
            default:
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.orange)
            }
        }
        .foregroundStyle(foregroundStyle)
    }
    
    private var foregroundStyle: some ShapeStyle {
        if let primitiveWithDefault = value as? PrimitiveWithDefault {
            return primitiveWithDefault.isDefault ? .secondary : .primary
        }
        
        return .secondary
    }
}
