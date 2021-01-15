//
//  LoginPresenter.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-27.
//

import UIKit
import Foundation

class LoginPresenter
{
    let defaults = UserDefaults.standard
    let loginViewController: LoginViewController
    var usersArray: [User] = [User]()

    init(loginViewController: LoginViewController)
    {
        self.loginViewController = loginViewController
        loadUsers()
    }

    // load all users from JSON
    func loadUsers()
    {
        if let filepath = Bundle.main.path(forResource: "logins", ofType: "json")
        {
            do
            {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                usersArray = try! JSONDecoder().decode([User].self, from: jsonData)
            }
            catch
            {
                print("Cannot load file")
            }
        }
        else
        {
            print("File not found")
        }
    }

    // check textFields for errors
    func checkForErrors() -> Bool
    {
        var errors: Bool = false

        if (!loginViewController.userNameTF.checkForValidInput())
        {
            errors = true
        }

        if (!loginViewController.passwordTF.checkForValidInput())
        {
            errors = true
        }

        if (errors)
        {
            return true
        }

        if (!userExists())
        {
            errors = true
        }

        return errors
    }

    // verify user exists
    func userExists() -> Bool
    {
        var userExists: Bool = false
        let userNameToCheck: String = loginViewController.userNameTF.text!.lowercased()

        for user in usersArray
        {
            if (user.username == userNameToCheck)
            {
                userExists = true
            }
        }

        // display alert if user does not exists
        if (!userExists)
        {
            let alert = UIAlertController(title: nil, message: "Sorry, that user name does not exist.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            loginViewController.present(alert, animated: true, completion: nil)
        }

        return userExists
    }

    // verify correct password entered
    func passwordCorrect() -> Bool
    {
        var isCorrect: Bool = false
        let passwordToCheck: String = loginViewController.passwordTF.text!.lowercased()

        for user in usersArray
        {
            if (user.password == passwordToCheck)
            {
                isCorrect = true
            }
        }

        // display alert if incorrect password
        if (!isCorrect)
        {
            let alert = UIAlertController(title: nil, message: "Incorrect Password...", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            loginViewController.present(alert, animated: true, completion: nil)
        }

        return isCorrect
    }

    // get current user
    func getCurrentUser(userName: String) -> User?
    {
        for user in usersArray
        {
            if (user.username == userName)
            {
                return user
            }
        }
        return nil
    }

}
