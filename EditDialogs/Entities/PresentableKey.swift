//
//  PresentableKey.swift
//  SwiftUI26
//
//  Created by Илья Аникин on 16.01.2026.
//

struct PresentableKey<T: Hashable>: Identifiable {
    let id: T
    let value: PrimitiveWithDefault
    let description: String
}
