//
//  PrimitiveView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

struct PrimitiveView: View {
    let value: PrimitiveWithDefault
    
    var body: some View {
        Group {
            switch value {
            case .bool(let value, _):
                Image(systemName: value ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                
            case .int(let value, _):
                Text(verbatim: "\(value)")
                
            case .string(let value, _):
                Text(verbatim: "\(value)")
                
            case .double(let value, _):
                Text(verbatim: String(format: "%.2f", value))
            }
        }
        .foregroundStyle(value.isDefault ? .secondary : .primary)
    }
}
