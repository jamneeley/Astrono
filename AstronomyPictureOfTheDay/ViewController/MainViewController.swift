//
//  MainViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var currentDate: Date?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.spaceGrey
        cv.isPagingEnabled = true
        return cv
    }()
    
    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        collectionView.register(APODCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(reloadCollectionView), userInfo: nil, repeats: false)
        APODController.shared.fetchAPODS(Date()) { (success) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return APODController.shared.APODS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! APODCollectionViewCell
        let apod = APODController.shared.APODS[indexPath.row]
        APODController.shared.fetchImage(forAPOD: apod) { (image) in
            DispatchQueue.main.async {
                guard let apodimage = image else {return}
                cell.apodImage = apodimage
            }
        }
        cell.apod = apod
        return cell
    }
}
