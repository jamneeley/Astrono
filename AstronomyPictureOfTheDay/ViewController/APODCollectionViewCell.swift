//
//  APODCollectionViewCell.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class APODCollectionViewCell: UICollectionViewCell {
    
    private let apodImageView: UIImageView = {
        let iV = UIImageView()
        return iV
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UITextView = {
        let tV = UITextView()
        tV.textAlignment = .left
        tV.textColor = .white
        tV.backgroundColor = .clear
        return tV
    }()

    private let activityIndicator: UIActivityIndicatorView = {
       let aI = UIActivityIndicatorView()
        aI.hidesWhenStopped = true
        aI.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        return aI
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = Colors.spaceGrey
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var reset = false {
        didSet{
            resetViews()
        }
    }
    
    var astronomyObject: AstronomyObject? {
        didSet{
            updateWithObject()
        }
    }
    
    var apod: APOD? {
        didSet {
            updateViews()
        }
    }
    
    var apodImage: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    func resetViews() {
        titleLabel.text = "Loading Image..."
        addSubview(activityIndicator)
        activityIndicator.center = center
        activityIndicator.startAnimating()
    }
    
    func updateWithObject() {
        stopAnimating()
        guard let object = astronomyObject,
        let image = UIImage(data: object.imageData)
        else {return}
        titleLabel.text = object.title
        descriptionLabel.text = object.explanation
        apodImageView.image = image
    }
    
    func updateImage() {
        guard let apodImage = apodImage else {return}
        apodImageView.image = apodImage
    }
    
    func updateViews() {
        stopAnimating()
        guard let apod = apod else {return}
        if let title = apod.title {
            titleLabel.text = title
        }
        if let description = apod.explanation {
            descriptionLabel.text = description
        }
    }
    
    func stopAnimating() {
        if activityIndicator.isAnimating == true {
            activityIndicator.stopAnimating()
        }
    }
    
    func setupViews() {
        addSubview(apodImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        apodImageView.translatesAutoresizingMaskIntoConstraints = false
        apodImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        apodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        apodImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        apodImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: apodImageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 60).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
}
