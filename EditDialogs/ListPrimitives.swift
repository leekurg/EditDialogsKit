//
//  ListPrimitives.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import Combine
import SwiftUI

struct ListPrimitives: View {
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
                        Text(verbatim: key.title)
                        if let desc = key.description {
                            Text(verbatim: desc)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            store.setEditing(key)
                        } label: {
                            Label(String("Edit"), systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle(String("Primitives"))
            .sheet(item: $store.editingKey) { key in
                EditValueView(id: key.id, value: key.value) { id, newValue in
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
    typealias PresentableKey = PrimitivePresentableKey<KeyID, Primitive>
    
    @Published var keys: [PresentableKey] = []
    @Published var isLoading: Bool = false
    @Published var editingKey: PresentableKey?
    
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
                title: "Bool with default",
                description: "Bool description",
                value: Primitive.bool(true)
            ),
            PresentableKey(
                id: "string",
                title: "String with default",
                description: "String description",
                value: Primitive.string("string-value")
            ),
            PresentableKey(
                id: "int",
                title: "Int with default",
                description: "Int description",
                value: Primitive.int(77)
            ),
            PresentableKey(
                id: "double",
                title: "Double with default",
                value: Primitive.double(3.146)
            )
        ]
        
        explicitlyMutatedKeys.forEach { (key, mutatedValue) in
            if let index = keys.firstIndex(ofId: key) {
                let prevKey = keys[index]

                keys[index] = PresentableKey(
                    id: prevKey.id,
                    title: prevKey.title,
                    description: prevKey.description,
                    value: mutatedValue
                )
            }
        }
        
        setLoading(false)
    }
    
    func setEditing(_ key: PresentableKey) {
        editingKey = key
    }
    
    func saveEdited(id: KeyID, newValue: Primitive) {
        explicitlyMutatedKeys[id] = newValue
        
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
        ListPrimitives()
    }
}

#Preview {
    ProxyView()
        .preferredColorScheme(.dark)
}
