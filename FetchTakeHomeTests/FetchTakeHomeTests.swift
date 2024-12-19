//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Christopher Head on 12/18/24.
//

import XCTest
@testable import FetchTakeHome

final class FetchTakeHomeTests: XCTestCase {
    func testDecodeRecipeList() throws {
        let recipesJSONData = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
        """.data(using: .utf8)!

        let recipeList = try JSONDecoder().decode(RecipeList.self, from: recipesJSONData)

        XCTAssertEqual(recipeList.recipes.count, 1)
    }
}
