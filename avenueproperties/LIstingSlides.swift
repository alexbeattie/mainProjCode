//
//  LIstingSlides.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/25/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import SDWebImage

class ListingSlides: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var listings: [Listing]?
    
    var images:[String] = []
    
    var listing: Listing? {
        didSet {
            self.images = (listing?.photos)!
            print(images)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        
        collectionView.register(ListingImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = listing?.photos?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListingImageCell

        let url = listing!.photos![indexPath.row]
        print(url)
        let urls = NSURL(string: url)
        let data = NSData(contentsOf: urls! as URL)
        
        cell.imageView.image = UIImage(data: data! as Data)
        cell.listing = listing

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }


     class ListingImageCell: BaseCell {
//        var photos:[String] = []
        var images = [String]()
        var listing:Listing? {
            didSet {
                for image in images {
                    print(image)
//                    imageView.sd_setImage(with: URL(string: "https://s3-us-west-2.amazonaws.com/cdn.simplyrets.com/properties/trial/home9.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
                }
                
                
                
//                imageView.sd_setImage(with: URL(string: "https://s3-us-west-2.amazonaws.com/cdn.simplyrets.com/properties/trial/home9.jpg"), placeholderImage: UIImage(named: "placeholder.png"))



            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.layer.masksToBounds = true
            iv.backgroundColor = UIColor.green
            return iv
        }()

         override func setupViews() {
            super.setupViews()

            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstraintsWithFormat("H:|[v0]|", views: imageView)
            addConstraintsWithFormat("V:|[v0]|", views: imageView)
        }
        
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
