//
//  ContentView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import Combine
import SwiftUI

struct ContentView: View {
    @StateObject private var store: Model
    
    init() {
        self._store = StateObject(wrappedValue: Model())
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.keys) { key in
                    LabeledContent {
                        PrimitiveView(value: key.value)
                    } label: {
                        Text(verbatim: key.description)
                        Text(verbatim: key.id)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        if !key.value.isDefault {
                            Button {
                                store.resetToDefault(id: key.id)
                            } label: {
                                Label(String("Revert"), systemImage: "arrow.counterclockwise")
                            }
                            .tint(.green)
                        }
                        
                        Button {
                            store.setEditing(key)
                        } label: {
                            Label(String("Edit"), systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle(String("Editable list"))
            .sheet(item: $store.editingKey) { key in
                EditValueView(id: key.id, value: key.value.primitive) { id, newValue in
                    print("Save new value for id: \(id) -> \(newValue)")
                    store.saveEdited(id: id, newValue: newValue)
                }
            }
        }
        .task {
            await store.load()
        }
    }
}

//MARK: - Model
@MainActor
fileprivate final class Model: ObservableObject {
    typealias KeyID = String
    
    @Published var keys: [PresentableKey<KeyID>] = []
    @Published var isLoading: Bool = false
    @Published var editingKey: PresentableKey<KeyID>?
    
    private var explicitlyMutatedKeys: [KeyID: Primitive] = [:]
    
    private func setLoading(_ value: Bool) {
        withAnimation(.snappy(duration: 0.4)) {
            self.isLoading = value
        }
    }
    
    func load() async {
        setLoading(true)
        
        keys = [
            PresentableKey(
                id: "bool",
                value: .bool(value: true, default: true),
                description: "Paid content"
            ),
            PresentableKey(
                id: "string",
                value: .string(value: "string-value", default: "string-value"),
                description: "Debug string exp"
            ),
            PresentableKey(
                id: "int",
                value: .int(value: 77, default: 77),
                description: "Debug int exp"
            ),
            PresentableKey(
                id: "double",
                value: .double(value: 3.146, default: 3.146),
                description: "Debug double exp"
            )
        ]
        
        explicitlyMutatedKeys.forEach { (key, mutatedValue) in
            if let index = keys.firstIndex(ofId: key) {
                let prevKey = keys[index]
                let newValue = try? PrimitiveWithDefault(
                    primitive: mutatedValue,
                    default: keys[index].value.default
                )
                
                if let newValue {
                    keys[index] = PresentableKey(
                        id: prevKey.id,
                        value: newValue,
                        description: prevKey.description
                    )
                }
            }
        }
        
        setLoading(false)
    }
    
    func setEditing(_ key: PresentableKey<KeyID>) {
        editingKey = key
    }
    
    func saveEdited(id: KeyID, newValue: Primitive) {
        if let key = keys.find(id) {
            if key.value.defaultPrimitive != newValue {
                explicitlyMutatedKeys[id] = newValue
            } else {
                explicitlyMutatedKeys.removeValue(forKey: id)
            }
        }
        
        editingKey = nil
        
        Task {
            await load()
        }
    }
    
    func resetToDefault(id: KeyID) {
        explicitlyMutatedKeys.removeValue(forKey: id)
        
        Task {
            await load()
        }
    }
}

fileprivate struct ProxyView: View {
    
    var body: some View {
        ContentView()
    }
}

#Preview("ContentView") {
    ProxyView()
        .preferredColorScheme(.dark)
}
