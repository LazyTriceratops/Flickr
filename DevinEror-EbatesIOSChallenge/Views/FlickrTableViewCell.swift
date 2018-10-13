//
//  FlickrTableViewCell.swift
//  DevinEror-EbatesIOSChallenge
//
//  Created by Devin Eror on 10/12/18.
//  Copyright © 2018 Devin Eror. All rights reserved.
//

import UIKit

class FlickrTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupCell(flickr: FlickrImage) {
        DispatchQueue.global(qos: .background).async {
            let data = flickr.thumbData!
            DispatchQueue.main.async {
                self.imgView.image = UIImage(data: data)!
            }
        }
    
        titleLabel.text = flickr.title
    }
}
