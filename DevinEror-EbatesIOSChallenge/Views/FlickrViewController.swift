//
//  ViewController.swift
//  DevinEror-EbatesIOSChallenge
//
//  Created by Devin Eror on 10/12/18.
//  Copyright © 2018 Devin Eror. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController {
    
    var flickrImages: [FlickrImage] = []
    var imgCache = NSCache<NSURL, UIImage>()
    
    @IBOutlet weak var flickrTable: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Recent Flickr"

        startActivityIndicator()

        FlickrClient.getRecent { (data, error) in
            self.stopActivityIndicator()
            if error != nil { print(error?.localizedDescription as Any); return }
            
            self.flickrImages = (data?.photos.photo)!
            self.flickrTable.reloadData()
        }
    }
    
    func startActivityIndicator() {
        activityIndicator.frame = self.view.frame
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}



extension FlickrViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flickrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flickrCell") as! FlickrTableViewCell
        
        let flickr = flickrImages[indexPath.row]
        
        cell.setupCell(flickr: flickr)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let details = FlickrDetailsVC()
        
        details.flickr = flickrImages[indexPath.row]
        
        self.navigationController?.pushViewController(details, animated: true)
    }
}
