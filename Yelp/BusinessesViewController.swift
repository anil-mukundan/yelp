//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar
        
        // Make Naviation Bar red
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        //        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
        //            self.businesses = businesses
        //
        //            for business in businesses {
        //                println(business.name!)
        //                println(business.address!)
        //            }
        //        })
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.business = self.businesses[indexPath.row]
        return cell
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filterViewController = navigationController.topViewController as! FiltersViewController
        filterViewController.delegate = self
    }

    func filtersViewController(filtersviewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        var deal = filters["deal"] as? Bool
        var sort = filters["sort"] as? YelpSortMode
        Business.searchWithTerm("Restaurants", sort: sort, categories: categories, deals: deal) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            self.tableView.reloadData()
        }
    }
    
}
