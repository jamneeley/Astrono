//
//  MainViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataSource = 0
    
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
        calculateNumberOfDays()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! APODCollectionViewCell
        let date = findDate(forIndexPath: indexPath.row)
        
        APODController.shared.fetchAPODS(date) { (apod) in
            guard let apod = apod else {return}
            APODController.shared.fetchImage(forAPOD: apod) { (image) in
                DispatchQueue.main.async {
                    guard let apodimage = image else {return}
                    cell.apodImage = apodimage
                    cell.apod = apod
                }
            }
        }
        
        return cell
    }
    
    
    func findDate(forIndexPath index: Int) -> Date {
        let date = Date()
        if index == 0 {
            return date
        } else {
            var dateComponent = DateComponents()
            dateComponent.day = -index
            
            let optionalDate = Calendar.current.date(byAdding: dateComponent, to: date)
            guard let oldDate = optionalDate else {return Date()}
            return oldDate
        }
    }
    
    func calculateNumberOfDays() {
        var dateComponents = DateComponents()
        dateComponents.year = 1995
        dateComponents.month = 6
        dateComponents.day = 20
        guard let startDate = Calendar.current.date(from: dateComponents),
        let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day else {return}
        dataSource = diffInDays
    }
}
