//
//  RecipeImageView.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import Foundation
import SwiftUI
import SwiftData

struct RecipeImageView : View {
    @Environment(RecipeImageCache.self) var recipeImageCache: RecipeImageCache

    let url: URL?

    @State var image: Image?

    var body: some View {
        if let image = image {
            image
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
        } else {
            Rectangle()
                .frame(width: 100, height: 100)
                .task {
                    guard let url = url else { return }

                    switch(await recipeImageCache.getImage(url: url)) {
                    case .success(let recipeImage):
                        image = recipeImage

                    case .failure(_):
                        break
                    }
                }
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: RecipeImage.self,
                                             configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    RecipeImageView(url: nil)
        .environment(RecipeImageCache(modelContext: modelContainer.mainContext))
}



