//
//  BeerViewController.swift
//  BeerPunkSearch
//
//  Created by Xavier on 10/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    //Landing Pad
    var beer: Beer?
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var beerIngredientsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        guard let beer = beer else { return }
        BeerController.getImage(for: beer) { (image) in
            DispatchQueue.main.async {
                self.beerImageView.image = image
                
            }
        }
    }
    
    func updateViews() {
        guard let beer = beer else { return}
        beerNameLabel.text = beer.name
        abvLabel.text = "\(beer.abv)"
        beerIngredientsLabel.text = beer.ingredientsString
    }
}
