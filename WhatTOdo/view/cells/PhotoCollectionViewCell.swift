//
//  PhotoCollectionViewCell.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-30.
//

import Kingfisher
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var photoImageView: UIImageView!

    func loadCell(url: String)
    {
        photoImageView.kf.setImage(with: URL(string: url))
    }
}
