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
    
    static func getBooks(for category: String, completion: @escaping (Result<(books: [Book], listName: String, bsDate: String), AppError>) -> ()) {
        
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
                    let listN = bookSearch.results.listName
                    let nytDate = bookSearch.results.bestsellersDate
                    completion(.success((books: bookHits, listName: listN, bsDate: nytDate)))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getGoogleBooks(for isbn: String, completion: @escaping (Result<([GoogleBook]), AppError>) -> ()) {
        
        let googleAPIEndpointURL = "https://www.googleapis.com/books/v1/volumes?q=\(isbn)&maxResults=2"
        
        guard let url = URL(string: googleAPIEndpointURL) else {
            completion(.failure(.badURL(googleAPIEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let bookSearch = try JSONDecoder().decode(GoogleSearch.self, from: data)
                    let bookHits = bookSearch.items
                    
                    completion(.success(bookHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}


