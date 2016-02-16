//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Joanna Meyer on 2/11/16.
//  Copyright (c) 2015 Joanna Meyer. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    var searchBar: UISearchBar!
    //var showsCancelButton = true
    
    @IBOutlet weak var tableView: UITableView!
    
    var filterButton: UISearchBar!
    //var showsCancelButton = true
    
    
    var filteredSearch: String?
    var searched = false
    var searchedTerm: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar
        
        searchDisplayController?.displaysSearchBarInNavigationBar = true
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar:UISearchBar, textDidChange searchText: String) {
        filteredSearch = searchBar.text
        searched = true
        //searchBar.showsCancelButton = true
        searchBar.setShowsCancelButton(true, animated: true)
        
        Business.searchWithTerm(filteredSearch!, sort: .Distance, categories: [], deals: true) {(businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
    }

    func searchBarSearchButtonClicked(searchBar:UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar:UISearchBar){
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.endEditing(true)
        searchBar.text = ""
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
            
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }





    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

