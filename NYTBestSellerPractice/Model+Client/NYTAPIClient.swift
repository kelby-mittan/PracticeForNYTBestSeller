//
//  NYTAPIClient.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTAPIClient {
    
    static func getBooks(for category: String, completion: @escaping (Result<[Book], AppError>) -> ()) {
        
        let list = category.replacingOccurrences(of: " ", with: "-")
        let nytEndpointURL = "https://api.nytimes.com/svc/books/v3/lists/current/\(list).json?api-key=O4upADVEFCAGpp8dntBivAZci04II1uv"
        
        guard let url = URL(string: nytEndpointURL) else {
            completion(.failure(.badURL(nytEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let bookSearch = try JSONDecoder().decode(BookSearch.self, from: data)
                    let bookHits = bookSearch.results.books
                    completion(.success(bookHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}


