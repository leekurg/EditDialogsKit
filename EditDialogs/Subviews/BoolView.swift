//
//  BoolView.swift
//  EditDialogs
//
//  Created by Илья Аникин on 17.01.2026.
//

import SwiftUI

struct BoolView: View {
    let value: Bool
    let imageSize: CGSize
    let format: BoolFormatStyle
    
    init(
        value: Bool,
        imageSize: CGSize = .init(width: 20, height: 20),
        format: BoolFormatStyle = .default
    ) {
        self.value = value
        self.imageSize = imageSize
        self.format = format
    }
    
    var body: some View {
        switch format {
        case .systemImage(let trueImage, let falseImage):
            Image(systemName: value ? trueImage : falseImage)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
        
        case .imageResource(let trueResource, let falseResource):
            Image(value ? trueResource : falseResource)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
        
        case .localizableString(let trueString, let falseString):
            Text(value ? trueString : falseString)
        }
    }
}

#Preview {
    BoolView(value: false, format: .default)
        .preferredColorScheme(.dark)
}
