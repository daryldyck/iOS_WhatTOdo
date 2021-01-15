//
//  AttractionPresenter.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-27.
//

import UIKit
import Foundation

class AttractionPresenter
{
    let defaults = UserDefaults.standard
    let attractionViewController: AttractionsViewController
    var attractionArray: [Attraction] = [Attraction]()
    var attractionPrefArray: [Attraction] = [Attraction]()
    var user: User?

    init(attractionViewController: AttractionsViewController, user: User)
    {
        self.attractionViewController = attractionViewController
        self.user = user

        loadAttractions()
        loadAttractionPrefs()
    }

    // load attractions form JSON
    func loadAttractions()
    {
        if let filepath = Bundle.main.path(forResource: "attractions", ofType: "json")
        {
            do
            {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                attractionArray = try! JSONDecoder().decode([Attraction].self, from: jsonData)
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

    // load attractions from saved preferences (User specific)
    func loadAttractionPrefs()
    {
        let fileName: String = self.user!.username + "_prefs"
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension("json")

        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            attractionPrefArray = try! JSONDecoder().decode([Attraction].self, from: data)
        }
        catch
        {
            print(error)
        }
     
        // update attractions list with user preferences (wishList and ratings)
        for attraction1 in attractionArray
        {
            for attraction2 in attractionPrefArray
            {
                if (attraction1.id == attraction2.id)
                {
                    attraction1.wishList = attraction2.wishList
                    attraction1.rating = attraction2.rating
                }
            }
        }
    }

    // save user preferences (wishList and ratings)
    func savePrefs(attraction: Attraction)
    {
        // add to preferences if is in wish list or user rated item
        if (attraction.wishList || attraction.rating > 0)
        {
            var inListAlready: Bool = false

            for attraction1 in attractionPrefArray
            {
                if (attraction1.id == attraction.id)
                {
                    inListAlready = true
                    attraction1.wishList = attraction.wishList
                    attraction1.rating = attraction.rating
                }
            }

            if (!inListAlready)
            {
                self.attractionPrefArray.append(attraction)
            }
        }
        else // remove if not in wish list or rating not selected
        {
            var inListAlready: Bool = false

            for attraction1 in attractionPrefArray
            {
                if (attraction1.id == attraction.id)
                {
                    inListAlready = true
                }
            }

            if (inListAlready)
            {
                for i in 0...attractionPrefArray.count - 1
                {
                    if (attractionPrefArray[i].id == attraction.id)
                    {
                        attractionPrefArray.remove(at: i)
                    }
                }
            }
        }

        //save user preferences (user speciific)
        let fileName: String = self.user!.username + "_prefs"
        saveToJsonFile(attractions: attractionPrefArray, fileName: fileName)
    }

    // save to internal JSON file
    func saveToJsonFile(attractions: [Attraction], fileName: String)
    {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension("json")

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(attractions)

            if let jsonString = String(data: jsonData, encoding: .utf8)
            {
                try jsonString.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
            }
        }
        catch
        {
            print(error)
        }
    }

    // read from internal JSON file
    func retrieveFromJsonFile(fileName: String)
    {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension("json")

        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            attractionPrefArray = try! JSONDecoder().decode([Attraction].self, from: data)
        } catch {
            print(error)
        }
    }

}
