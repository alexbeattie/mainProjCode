////
////  HomeCell.swift
////  avenueproperties
////
////  Created by Alex Beattie on 9/25/17.
////  Copyright © 2017 Artisan Branding. All rights reserved.
////
//
//import UIKit
//
//class HomeCell: UICollectionViewCell {
//    var homeViewController: HomeViewController?
//
//    var listing: Listing? {
//        didSet {
//            if let imageName = listing?.photos.first {
//                thumbnailImageView.image = UIImage(named: imageName)
//            }
//            backgroundColor = UIColor.black
//
//        }
//    }
//
//    let cellId = "cellId"
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let thumbnailImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "frozen")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    func setupViews() {
//
//        backgroundColor = UIColor.black
//        addSubview(thumbnailImageView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailImageView)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: thumbnailImageView)
//    }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
