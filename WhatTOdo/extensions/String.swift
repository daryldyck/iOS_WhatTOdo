//
//  String.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-30.
//

import Foundation

extension String
{
    // add option to simplify website String
    func toWebsiteString() -> String
    {
        return self.lowercased()
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "www.", with: "")
    }
}
