//
//  BookDetailView.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

    lazy var contentViewSize = CGSize(width: centerView.frame.width, height: centerView.frame.height + 400)
    
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.frame = centerView.bounds
        sv.contentSize = contentViewSize
        
        return sv
    }()
    
    public lazy var centerView: UIView = {
        let centeredV = UIView()
//        let xCoord = self.bounds.width / 2 - 165
//        let yCoord = self.bounds.height / 2 - 250
//        let width = self.bounds.width / 1.25
//        let height = self.bounds.height / 2
//        let centeredV = UIView(frame: CGRect(x: xCoord, y: yCoord, width: width, height: height))
        centeredV.backgroundColor = .green
        return centeredV
    }()
    
    public lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .systemTeal
        return iv
    }()
    
    public lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Title"
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "By line"
        return label
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
        setupCenteredViewConstraints()
        setupImageConstraints()
        setupTitleLabelConstraints()
    }
    

    private func setupCenteredViewConstraints() {
        addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.layer.cornerRadius = 10
        let width = self.bounds.width / 1.25
        let height = self.bounds.height / 2
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.widthAnchor.constraint(equalToConstant: width),
            centerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupImageConstraints() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 15),
            bookImageView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 15),
            bookImageView.widthAnchor.constraint(equalTo: centerView.widthAnchor, multiplier: 0.35),
            bookImageView.heightAnchor.constraint(equalTo: centerView.heightAnchor, multiplier: 0.35)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(bookTitle)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            bookTitle.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            bookTitle.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -8)
        ])
    }
}
