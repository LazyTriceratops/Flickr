//
//  FlickrDetailsVC.swift
//  DevinEror-EbatesIOSChallenge
//
//  Created by Devin Eror on 10/12/18.
//  Copyright © 2018 Devin Eror. All rights reserved.
//

import UIKit

class FlickrDetailsVC: UIViewController {
    
    var mainTitle: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var mainImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var flickr: FlickrImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.view.backgroundColor = .white
        
        self.view.addSubview(mainImage)
        self.view.addSubview(mainTitle)
        
        setupConstraints()
        setupContent()
    }
    
    func setupConstraints() {
        
        [
            mainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            mainImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            mainTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            mainTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            mainTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            mainTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ].forEach {
            $0.isActive = true
        }
    }
    
    func setupContent() {
        DispatchQueue.global(qos: .background).async {
            let data = self.flickr.fullImage
            DispatchQueue.main.async {
                self.mainImage.image = UIImage(data: data!)
            }
        }
        
        self.mainTitle.text = flickr.title
    }
}
