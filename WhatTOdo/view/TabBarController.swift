//
//  TabBarController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-27.
//

import PopMenu
import UIKit

class TabBarController: UITabBarController
{
    let menuViewController = PopMenuViewController()
    var displayAboutDialog: Bool = false
    let defaults = UserDefaults.standard
    var user: User?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setup()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // setup nav buttons and other values
    func setup()
    {
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_header"))

        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(logout(sender:)))

        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .plain, target: self, action: #selector(menu(sender:)))

        // set user in attractions viewController
        let attractionsViewController = self.viewControllers![1] as! AttractionsViewController
        attractionsViewController.user = user
    }

    // logout of app
    @objc func logout(sender: AnyObject)
    {
        defaults.set(nil, forKey: Login.CURRENT_USER.rawValue)
        _ = navigationController?.popToRootViewController(animated: true)
    }

    // display overflow menu
    @objc func menu(sender: AnyObject)
    {
        let menuViewController = PopMenuViewController(sourceView: self.navigationItem.rightBarButtonItem,
                                                       actions: [PopMenuDefaultAction(title: "About",
                                                                                      image: UIImage(named: "ic_about"),
                                                                                      color: UIColor(named: "textOnBackgroundSecondary"),
                                                                                      didSelect: { (PopMenuAction) in
                                                                                          self.displayAboutDialog = true
                                                                                      })])
        
        menuViewController.appearance.popMenuColor.backgroundColor = .solid(fill: UIColor(named: "cardBackground")!)
        menuViewController.appearance.popMenuCornerRadius = 7
        menuViewController.didDismiss = { (selected) in
            self.aboutDialog()
        }

        present(menuViewController, animated: true, completion: nil)
    }

    // display about dialog
    func aboutDialog()
    {
        if (displayAboutDialog)
        {
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            {
                let aboutDialog = UIAlertController(title: "WhatTOdo",
                                                    message: "Version: \(version)\n\nby Daryl Dyck\ndaryl@deniteappz.com",
                                                    preferredStyle: .alert)

                aboutDialog.addAction(UIAlertAction(title: "CLOSE", style: .cancel, handler: nil))

                self.present(aboutDialog, animated: true, completion: nil)
                displayAboutDialog = false
            }
        }
    }
}
