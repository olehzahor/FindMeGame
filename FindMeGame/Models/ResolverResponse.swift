//
//  ResolverResponse.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import Foundation

struct ResolverResponse: Decodable {
    var shouldPass: Bool
    var url: String?
}
