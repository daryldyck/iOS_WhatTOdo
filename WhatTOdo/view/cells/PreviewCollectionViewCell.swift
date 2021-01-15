//
//  PreviewCollectionViewCell.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-30.
//

import Kingfisher
import UIKit

class PreviewCollectionViewCell: UICollectionViewCell
{
    var attractionPresenter: AttractionPresenter?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    var attraction: Attraction?
    
    func loadCell(attraction: Attraction, attractionPresenter: AttractionPresenter)
    {
        self.attraction = attraction
        self.attractionPresenter = attractionPresenter
        image.kf.setImage(with: URL(string: attraction.photosList[0]))
        
        nameLabel.text = attraction.name
        addressLabel.text = attraction.address
        wishListButton.isSelected = attraction.wishList
    }
    
    @IBAction func wishListToggle(_ sender: Any)
    {
        wishListButton.isSelected.toggle()
        self.attraction!.wishList = wishListButton.isSelected
        self.attractionPresenter!.savePrefs(attraction: self.attraction!)
    }
}
