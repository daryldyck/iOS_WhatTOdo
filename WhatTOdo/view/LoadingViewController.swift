//
//  LoadingViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-30.
//

import UIKit

class LoadingViewController: UITabBarController
{
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loading.startAnimating()    
    }
    


}
