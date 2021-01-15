//
//  DetailsViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-30.
//

import Cosmos
import Kingfisher
import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var attractionPresenter: AttractionPresenter?
    var attraction: Attraction?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var websiteB: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var wishListButton: UIButton!
    @IBOutlet weak var ratingBar: CosmosView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }

    // setup all views
    func setup()
    {
        photoCollection.delegate = self
        photoCollection.dataSource = self

        imageView.kf.setImage(with: URL(string: attraction!.photosList[0]))
        nameLabel.text = attraction!.name
        addressLabel.text = attraction!.address
        phoneButton.setTitle(attraction!.phone.toPhoneString(), for: .normal)
        websiteB.setTitle(attraction!.website.toWebsiteString(), for: .normal)
        priceLabel.text = attraction!.price
        descriptionTF.text = attraction!.description
        wishListButton.isSelected = attraction!.wishList
        ratingBar.rating = Double(attraction!.rating)
        ratingBar.didFinishTouchingCosmos = { rating in
            self.attraction!.rating = Int(rating)
            self.attractionPresenter!.savePrefs(attraction: self.attraction!)
        }
    }

    // open dialer with selected phone number
    @IBAction func phoneClick(_ sender: Any)
    {
        // open dialier with phone number
//        if let phoneCallURL = URL(string: "tel://\(attraction!.phone)")
//        {
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL))
//            {
//                application.open(phoneCallURL, options: [:], completionHandler: nil)
//            }
//        }
    }

    // open website
    @IBAction func websiteClick(_ sender: UIButton)
    {
        performSegue(withIdentifier: "webSegua", sender: nil)
    }
    
    // toggle wishList button
    @IBAction func wishListToggle(_ sender: Any)
    {
        wishListButton.isSelected.toggle()
        self.attraction!.wishList = wishListButton.isSelected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare")
        if (segue.identifier == Seguas.WEB.rawValue)
        {
            let webScreen = segue.destination as! WebViewController
            webScreen.urlString = self.attraction!.website
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        attraction!.photosList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.loadCell(url: attraction!.photosList[indexPath.item])
        return cell
    }

    // set main image with second selected image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        imageView.kf.setImage(with: URL(string: attraction!.photosList[indexPath.item]))
    }

}
