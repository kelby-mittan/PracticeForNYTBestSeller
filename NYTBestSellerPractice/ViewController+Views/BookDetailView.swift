//
//  BookDetailView.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

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
    }
    
//    private func createTheView() {
//
//        let xCoord = self.view.bounds.width / 2 - 165
//        let yCoord = self.view.bounds.height / 2 - 250
//        let width = self.view.bounds.width / 1.25
//        let height = self.view.bounds.height / 2
//        let centeredView = UIView(frame: CGRect(x: xCoord, y: yCoord, width: width, height: height))
//        centeredView.backgroundColor = .blue
//        self.view.addSubview(centeredView)
//    }
    private func setupCenteredViewConstraints() {
        addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = self.bounds.width / 1.25
        let height = self.bounds.height / 2
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.widthAnchor.constraint(equalToConstant: width),
            centerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
