//
//  Resolver.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import Foundation

class Resolver {
    let apiService = ApiService()
    var resolverUrl: URL?
    
    private func disableCaches() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
    }
    
    func askToResolve(completion: @escaping (URL?) -> Void) {
        guard let url = resolverUrl else { return }
        
        apiService.fetch(url: url) { (result: Result<ResolverResponse, Error>) in
            switch result {
            case .success(let response):
                if !response.shouldPass,
                   let urlString = response.url,
                   let url = URL(string: urlString) {
                    completion(url)
                } else { completion(nil) }
            default:
                completion(nil)
            }
        }
    }
    
    init(url: String, ignoreCaches: Bool = true) {
        self.resolverUrl = URL(string: url)
        if ignoreCaches { disableCaches() }
    }
}
