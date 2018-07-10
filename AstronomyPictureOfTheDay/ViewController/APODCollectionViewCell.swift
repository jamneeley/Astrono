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
    
    private let webview: UIWebView = {
       let wV = UIWebView()
        return wV
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UITextView = {
        let tV = UITextView()
        tV.textAlignment = .left
        tV.textColor = .white
        tV.backgroundColor = .clear
        return tV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = Colors.spaceGrey
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func updateWithObject() {
        setupImageView()
        guard let object = astronomyObject,
        let image = UIImage(data: object.imageData)
        else {return}
        titleLabel.text = object.title
        descriptionLabel.text = object.explanation
        apodImageView.image = image
    }
    
    func updateImage() {
        setupImageView()
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
    
    func dismissWebView() {
        if webview.superview == self {
            webview.removeFromSuperview()
        }
    }
    
    func dismissImageView() {
        if apodImageView.superview == self {
            apodImageView.removeFromSuperview()
        }
    }
    
    func showVideo(withURL url: URL) {
        setupWebView()
        webview.loadRequest(URLRequest(url: url))
    }
    
    func setupWebView() {
        if webview.superview == nil {
            dismissImageView()
            addSubview(webview)
            webview.translatesAutoresizingMaskIntoConstraints = false
            webview.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
            webview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            webview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            webview.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        }
    }
    
    func setupImageView() {
        if apodImageView.superview == nil {
            dismissWebView()
            addSubview(apodImageView)
            apodImageView.translatesAutoresizingMaskIntoConstraints = false
            apodImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
            apodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            apodImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            apodImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        }
    }
    
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
    }
}
