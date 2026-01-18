//
//  ContentView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import EditDialogsKit
import Combine
import SwiftUI

struct ContentView: View {
    @State var tab: AppTab = .primitiveWithDefaults
    
    var body: some View {
        TabView {
            Tab("Primitives", systemImage: "1.circle") {
                ListPrimitives()
                    .primitiveFormatBool(
                        .imageNamed(
                            true: "true",
                            false: .named("false", bundle: .main)
                        )
                    )
            }
            
            Tab("With defaults", systemImage: "2.circle") {
                ListPrimitivesWithDefaults()
            }
        }
    }
    
    enum AppTab: Hashable {
        case primitive
        case primitiveWithDefaults
    }
}

#Preview("ContentView") {
    ContentView()
        .preferredColorScheme(.dark)
}
