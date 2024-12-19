//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @State var recipes: [Recipe] = []
    @State var recipeURL: URL?
    @State var malformedDataError: Bool = false

    var body: some View {
        List {
            Section {
                if recipes.isEmpty {
                    Text("No Recipes")
                } else {
                    ForEach(recipes) { recipe in
                        HStack {
                            RecipeImageView(url: URL(string: recipe.thumbnailURL))
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.title2)
                                Text(recipe.cuisine)
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    Button("Complete") {
                        recipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
                    }

                    Spacer()

                    Button("Malformed") {
                        recipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
                    }

                    Spacer()

                    Button("Empty") {
                        recipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
                    }
                }
            }
        }
        .alert(Text("Malformed data"), isPresented: $malformedDataError) {
            Button("OK") {}
        }
        .onChange(of: recipeURL) { _, newValue in
            guard let newRecipeURL = newValue else { return }

            recipes.removeAll()

            Task {
                switch(await RecipeClient.getReceipes(url: newRecipeURL)) {
                case .success(let recipeList):
                    recipes = recipeList.recipes

                case .failure(_):
                    malformedDataError = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
