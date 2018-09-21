//
//  TvShowService.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import UIKit

typealias HttpServiceResponse = (Data?, URLResponse?, Error?) -> Swift.Void

protocol ITvShowService {
    func fetchPopular(completion: @escaping (TvShowResult?) -> Void)
    func search(withQuery query: String, completion: @escaping (TvShowResult?) -> Void)
}

class TvShowService: ITvShowService {

    private let token: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"

    public func get(url: URL!, onCompletion: @escaping HttpServiceResponse) {
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        session.dataTask(with: urlRequest, completionHandler: onCompletion).resume()
    }

    private func absoluteUrl(forPath path: String) -> URL {
         return URL(string:"https://api.themoviedb.org/3/\(path)")!
    }

    func fetchPopular(completion: @escaping (TvShowResult?) -> Void) {
        let url = absoluteUrl(forPath: "tv/popular?api_key=\(token)&page=1")
        return executeTVShowRequest(with: url, completion: completion)
    }

    func search(withQuery query: String, completion: @escaping (TvShowResult?) -> Void) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = absoluteUrl(forPath: "search/tv?api_key=\(token)&query=\(escapedQuery)&page=1")
        return executeTVShowRequest(with: url, completion: completion)
    }

    private func executeTVShowRequest(with url: URL, completion: @escaping (TvShowResult?) -> Void) {
        get(url: url, onCompletion: { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            guard let data = data else { return }
            let result = try? JSONDecoder().decode(TvShowResult.self, from: data)
            DispatchQueue.main.async { completion(result) }
        })
    }
}


