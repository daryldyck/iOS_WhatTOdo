//
//  LoginViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-26.
//

import UIKit

class LoginViewController: UIViewController
{
    let defaults = UserDefaults.standard
    var loginPresenter: LoginPresenter?
    var user: User?

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loginPresenter = LoginPresenter(loginViewController: self)

        setup()

        if (defaults.bool(forKey: Login.REMEMBER_ME.rawValue) && defaults.string(forKey: Login.CURRENT_USER.rawValue) != nil)
        {
            login()
        }
    }

    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // setup views
    func setup()
    {
        rememberSwitch.isOn = defaults.bool(forKey: Login.REMEMBER_ME.rawValue)
    }

    @IBAction func onRememberChanged(_ sender: UISwitch)
    {
        defaults.set(sender.isOn, forKey: Login.REMEMBER_ME.rawValue)
    }

    @IBAction func loginButton(_ sender: Any)
    {
        if (self.loginPresenter!.checkForErrors())
        {
            return
        }

        if (loginPresenter!.userExists() && loginPresenter!.passwordCorrect())
        {
            defaults.set(userNameTF.text?.lowercased(), forKey: Login.CURRENT_USER.rawValue)
            login()
        }
    }

    // login user
    func login()
    {
        if let validUser = loginPresenter!.getCurrentUser(userName: defaults.string(forKey: Login.CURRENT_USER.rawValue)!)
        {
            user = validUser
            performSegue(withIdentifier: "homeSegua", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "homeSegua")
        {
            let tabCtrl: TabBarController = segue.destination as! TabBarController
            tabCtrl.user = user
        }
    }
}
