//
//  RecipeClient.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import Foundation

enum RecipeClientError: Error {
    case noResponse
    case badResponse
    case unknown
}

class RecipeClient {
    static func getReceipes(url: URL) async -> Result<RecipeList, RecipeClientError> {
        let urlRequest = URLRequest(url: url)

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)

            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch(httpURLResponse.statusCode) {
            case 200:
                do {
                    return .success(try JSONDecoder().decode(RecipeList.self, from: data))
                } catch(_) {
                    return .failure(.badResponse)
                }
            default:
                return .failure(.unknown)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
