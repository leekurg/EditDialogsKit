//
//  Collection+.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

extension Collection where Element: Identifiable {
    /// Finds an element by **ID** withing collection.
    ///
    /// Returns ``Optional\none`` when no elements was found.
    ///
    func find(_ id: Element.ID?) -> Element? {
        self.first { $0.id == id }
    }

    /// Finds an index of the element by it's **ID** withing collection.
    ///
    /// Returns ``Optional\none`` when no elements was found.
    ///
    func firstIndex(ofId id: Element.ID) -> Index? {
        self.firstIndex { $0.id == id }
    }
}
