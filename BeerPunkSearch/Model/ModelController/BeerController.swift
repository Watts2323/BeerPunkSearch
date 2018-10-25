//
//  BeerController.swift
//  BeerPunkSearch
//
//  Created by Xavier on 10/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class BeerController {
    
    static let baseURL = URL(string: "https://api.punkapi.com/v2/beers")
    
    static func getBeersForFood(food: String, completion: @escaping ([Beer]?) -> Void) {
        
        //Step 1- Construct URL
        guard let baseURL = baseURL else { completion(nil); return}
        
        //Create our URL Components because we need a URL Query item
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //Need to account for spaces in the seacrch term
        let foodComponents = food.components(separatedBy: " ")
        let foodSearchTerm = foodComponents.joined(separator: "_")
        
        //Create QueryItem
        let searchFoodQueryItem = URLQueryItem(name: "food", value: foodSearchTerm)
        // our URL should and will look like this: "https://api.punkapi.com/v2/beers?food<<user input>>
        components?.queryItems = [searchFoodQueryItem]
        
        guard let url = components?.url else {completion(nil); return}
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            guard let data = data else {completion(nil); return}
            let decoder = JSONDecoder()
            do{
                let beers = try decoder.decode([Beer].self, from: data)
                completion(beers)
            } catch {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            }.resume()
    }
    
    static func getImage(for beer: Beer, completion: @escaping (UIImage?) -> Void) {
        
        //Step 1 - Construct the uRL
        guard let url = beer.imageURL else { completion(nil); return}
        
        //step 3- Data TASK AND resume
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            guard let data = data else { completion(nil); return}
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
}
