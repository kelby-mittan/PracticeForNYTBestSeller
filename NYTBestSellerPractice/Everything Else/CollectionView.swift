//
//  CollectionView.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Gemini

class CollectionView: UIView {

    public lazy var geminiCollectionView: GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
//        layout.itemSize = CGSize(width: 120, height: 400)
        let cv = GeminiCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        cv.backgroundColor = .darkGray
//        cv.isHidden = true
        return cv
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupGeminiCollectionViewConstraints()
    }
    
    private func setupGeminiCollectionViewConstraints() {
        addSubview(geminiCollectionView)
        geminiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            geminiCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            geminiCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            geminiCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            geminiCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
