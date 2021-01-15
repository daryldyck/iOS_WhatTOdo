//
//  AttractionsViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-26.
//

import UIKit

class AttractionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var attractionPresenter: AttractionPresenter?
    var user: User?
    var attraction: Attraction?
    var indexPath: IndexPath?
    var reloadAttraction: Bool = false
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        attractionPresenter = AttractionPresenter(attractionViewController: self, user: user!)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool)
    {
        if (reloadAttraction)
        {
            collectionView.reloadItems(at: [indexPath!])
            reloadAttraction = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        attractionPresenter!.attractionArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCell", for: indexPath) as! PreviewCollectionViewCell
        cell.loadCell(attraction: attractionPresenter!.attractionArray[indexPath.item], attractionPresenter: self.attractionPresenter!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        attraction = attractionPresenter?.attractionArray[indexPath.item]
        self.indexPath = indexPath
        self.reloadAttraction = true
        performSegue(withIdentifier: "detailsSegua", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == Seguas.DETAILS.rawValue)
        {
            let detailsScreen = segue.destination as! DetailsViewController
            detailsScreen.attraction = self.attraction!
            detailsScreen.attractionPresenter = self.attractionPresenter!
        }
    }
}
