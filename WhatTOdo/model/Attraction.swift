//
//  Attraction.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-27.
//

import Foundation

class Attraction: Codable
{
    let id: Int
    var name: String
    var address: String
    var photosList: [String]
    var phone: Int64
    var website: String
    var description: String
    var price: String
    var rating: Int
    var wishList: Bool

    init(id: Int, name: String, address: String, photosList: [String], phone: Int64, website: String, description: String, price: String)
    {
        self.id = id
        self.name = name
        self.address = address
        self.photosList = photosList
        self.phone = phone
        self.website = website
        self.description = description
        self.price = price
        self.rating = 0
        self.wishList = false
    }
    
    init(id: Int, name: String, address: String, photosList: [String], phone: Int64, website: String, description: String, price: String, rating: Int, wishList: Bool)
    {
        self.id = id
        self.name = name
        self.address = address
        self.photosList = photosList
        self.phone = phone
        self.website = website
        self.description = description
        self.price = price
        self.rating = rating
        self.wishList = wishList
    }
}
