//
//  Beer.swift
//  BeerPunkSearch
//
//  Created by Xavier on 10/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

struct Beer: Decodable {
    var name: String
    var tagline: String
    var abv: Double
    var imageURL: URL?
    let ingredients: Ingredients
    
    var ingredientsString: String {
        
        var ingredientsArray: [String] = []
        for malt in ingredients.malts {
            ingredientsArray.append(malt.name)
        }
        return ingredients.malts.compactMap {$0.name}.joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case tagline
        case imageURL = "image_url"
        case abv
        case ingredients
    }
}

struct Ingredients: Decodable {
    let malts: [Malt]
    
    enum CodingKeys: String, CodingKey {
        case malts = "malt"
    }
}

struct Malt: Decodable {
    let name: String
}
