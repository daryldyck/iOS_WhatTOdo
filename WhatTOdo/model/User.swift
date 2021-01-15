//
//  User.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-27.
//

import Foundation

struct User: Codable
{
    let username: String
    var password: String
    
    init(username: String, password: String)
    {
        self.username = username
        self.password = password
    }
}
