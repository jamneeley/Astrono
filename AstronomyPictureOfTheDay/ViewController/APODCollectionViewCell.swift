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
        iV.image = #imageLiteral(resourceName: "space")
        return iV
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "(Title)"
        return label
    }()
    
    private let descriptionLabel: UITextView = {
        let tV = UITextView()
        tV.textAlignment = .left
        tV.textColor = .white
        tV.text = "(Description)"
        tV.backgroundColor = .clear
        return tV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = Colors.plutoBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    func updateImage() {
        guard let apodImage = apodImage else {return}
        apodImageView.image = apodImage
    }
    
    func updateViews() {
        guard let apod = apod else {return}
        if let title = apod.title {
            titleLabel.text = title
        }
        if let description = apod.explanation {
            descriptionLabel.text = description
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
