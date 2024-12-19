//
//  RecipeImageCache.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import Foundation
import SwiftData
import SwiftUI

extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }

        self = .init(uiImage: image)
    }
}

enum RecipeImageCacheError: Error {
    case loadFailed
    case saveFailed
}

@MainActor
class RecipeImageCache: Observable {
    private let modelContext: ModelContext

    func getImage(url: URL) async -> Result<Image, RecipeImageCacheError> {
        let recipeImageDescriptor = FetchDescriptor<RecipeImage>(predicate: #Predicate { recipeImage in
            return recipeImage.url == url
        })

        let recipeImages = try? modelContext.fetch(recipeImageDescriptor)

        if let recipeImage = recipeImages?.first, let recipeImageData = recipeImage.image, let recipeImageImage = Image(data: recipeImageData) {
            return .success(recipeImageImage)
        } else {
            do {
                let (imageData, _) = try await URLSession.shared.data(from: url)

                let recipeImage = RecipeImage(url: url, image: imageData)

                modelContext.insert(recipeImage)

                try modelContext.save()

                if let recipeImageImage =  Image(data: imageData) {
                    return .success(recipeImageImage)
                } else {
                    return .failure(.loadFailed)
                }
            } catch {
                return .failure(.loadFailed)
            }
        }
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
