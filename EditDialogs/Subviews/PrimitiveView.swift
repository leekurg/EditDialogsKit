//
//  PrimitiveView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

//import Format
import SwiftUI

struct PrimitiveView: View {
    let value: any PrimitiveValue
    
    @Environment(\.primitiveBoolFormat) var primitiveBoolFormat
    @Environment(\.primitiveIntFormat) var primitiveIntFormat
    @Environment(\.primitiveStringFormat) var primitiveStringFormat
    @Environment(\.primitiveDoubleFormat) var primitiveDoubleFormat
    
    var body: some View {
        Group {
            switch value.value {
            case let bool as Bool:
                BoolView(value: bool, format: primitiveBoolFormat)
                
            case let int as Int:
                Text(int, format: primitiveIntFormat)
                
            case let string as String:
                Text(verbatim: primitiveStringFormat.format(string))
                
            case let double as Double:
                Text(double, format: primitiveDoubleFormat)
                
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
