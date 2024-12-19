//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import Foundation
import SwiftData

@Model
final class RecipeImage {
    @Attribute(.unique) var url: URL
    @Attribute(.externalStorage) var image: Data?

    init(url: URL, image: Data? = nil) {
        self.url = url
        self.image = image
    }
}
