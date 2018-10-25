//
//  BeerTableViewController.swift
//  BeerPunkSearch
//
//  Created by Xavier on 10/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {
    
    //MARK: - Constants and Variables
    
    var beers: [Beer] = []
    
    //MARK: - Outlets
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        
        let beer = beers[indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = beer.name
        cell.detailTextLabel?.text = beer.tagline
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailBeerVC" {
            guard let destinationVC = segue.destination as? BeerDetailViewController,
                let beerIndex = tableView.indexPathForSelectedRow else { return}
            
            
            let beer = beers[beerIndex.row]
            destinationVC.beer = beer
            
        }
    }
}

extension BeerTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //Unwrap the text from the search bar
        guard let food = searchBar.text else { return }
        
        BeerController.getBeersForFood(food: food) { (beers) in
            guard let beers = beers else { return}
            self.beers = beers
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
