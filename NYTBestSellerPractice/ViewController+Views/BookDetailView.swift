//
//  BookDetailView.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    //    lazy var contentViewSize = CGSize(width: centerView.frame.width, height: centerView.frame.height + 400)
    //
    //    public lazy var scrollView: UIScrollView = {
    //        let sv = UIScrollView(frame: .zero)
    //        sv.frame = centerView.bounds
    //        sv.contentSize = contentViewSize
    //
    //        return sv
    //    }()
    
    public lazy var centerView: UIView = {
        let centeredV = UIView()
        
        //        centeredV.frame.size = contentViewSize
        //        centeredV.layer.borderWidth = 4
        centeredV.layer.borderColor = UIColor.lightText.cgColor
        centeredV.backgroundColor = .systemBackground
        centeredV.isOpaque = false
        //        centeredV.backgroundColor = .quaternarySystemFill
        centeredV.alpha = 0.9
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
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Maybe you should talk to someone"
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        label.textColor = .white
        label.text = "By Kobe Bryant and Kobe Bryant"
        return label
    }()
    
    public lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        label.textColor = .white
        label.text = "Rank: 1"
        return label
    }()
    
    public lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "11 weeks on list"
        return label
    }()
    
    public lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "book.fill"), for: .normal)
//        button.contentMode = .scaleToFill
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        label.textColor = .white
        label.text = "The Mamba Mentality: How I Play is Kobe Bryant’s personal perspective of his life and career on the basketball court and his exceptional, insightful style of playing the game—a fitting legacy from the late Los Angeles Laker superstar. In the wake of his retirement from professional basketball, Kobe “The Black Mamba” Bryant decided to share his vast knowledge and understanding of the game to take readers on an unprecedented journey to the core of the legendary “Mamba mentality.” Citing an obligation and an opportunity to teach young players, hardcore fans, and devoted students of the game how to play it “the right way,” The Mamba Mentality takes us inside the mind of one of the most intelligent, analytical, and creative basketball players ever. In his own words, Bryant reveals his famously detailed approach and the steps he took to prepare mentally and physically to not just succeed at the game, but to excel. Readers will learn how Bryant studied an opponent, how he channeled his passion for the game, how he played through injuries. They’ll also get fascinating granular detail as he breaks down specific plays and match-ups from throughout his career. Bryant’s detailed accounts are paired with stunning photographs by the Hall of Fame photographer Andrew D. Bernstein. Bernstein, long the Lakers and NBA official photographer, captured Bryant’s very first NBA photo in 1996 and his last in 2016—and hundreds of thousands in between, the record of a unique, twenty-year relationship between one athlete and one photographer. The combination of Bryant’s narrative and Bernstein’s photos make The Mamba Mentality an unprecedented look behind the curtain at the career of one of the world’s most celebrated and fascinating athletes."
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
        //        setupScrollViewConstraints()
        setupCenteredViewConstraints()
        setupImageConstraints()
        setupTitleLabelConstraints()
        setupByLineConstraints()
        setupRankLabelConstraints()
        setupByWeeksOnListConstraints()
        setupButtonConstraints()
        setupDescriptionConstraints()
    }
    
    
    private func setupCenteredViewConstraints() {
        addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.layer.cornerRadius = 10
        let width = self.bounds.width / 1.15
        let height = self.bounds.height / 1.35
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.widthAnchor.constraint(equalToConstant: width),
            centerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    //    private func setupScrollViewConstraints() {
    //        addSubview(scrollView)
    //        scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        scrollView.layer.cornerRadius = 10
    //        let width = self.bounds.width / 1.25
    //        let height = self.bounds.height / 2
    //
    //        NSLayoutConstraint.activate([
    //            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
    //            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
    //            scrollView.widthAnchor.constraint(equalToConstant: width),
    //            scrollView.heightAnchor.constraint(equalToConstant: height)
    //        ])
    //    }
    
    private func setupImageConstraints() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 10),
            bookImageView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 10),
            bookImageView.widthAnchor.constraint(equalTo: centerView.widthAnchor, multiplier: 0.35),
            bookImageView.heightAnchor.constraint(equalTo: centerView.heightAnchor, multiplier: 0.25)
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
    
    private func setupByLineConstraints() {
        addSubview(byLine)
        byLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            byLine.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 5),
            byLine.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            byLine.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor)
        ])
    }
    
    private func setupRankLabelConstraints() {
        addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankLabel.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: byLine.centerXAnchor)
        ])
    }
    
    private func setupByWeeksOnListConstraints() {
        addSubview(weeksOnListLabel)
        weeksOnListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weeksOnListLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            weeksOnListLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            weeksOnListLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 60),
            menuButton.heightAnchor.constraint(equalToConstant: 60),
            menuButton.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: byLine.trailingAnchor)
        ])
        menuButton.imageView?.contentMode = .scaleToFill
    }
    
    private func setupDescriptionConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: weeksOnListLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: centerView.bottomAnchor)
        ])
    }
}
