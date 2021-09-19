//
//  AsyncImage.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

// MARK: - Type - AsyncImage -

/**
 AsyncImage will load feed image asynchronously and display on the list
 */
struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder
        placeholder: () -> Placeholder,
        @ViewBuilder
        image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
