//
//  BookDetailController.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController {
    
    public var modallView = BookDetailView()
    
    override func loadView() {
        view = modallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .clear
//        view.alpha = 0.90
//        view.isOpaque = false
        
        modallView.backgroundColor = .clear

//        self.preferredContentSize = CGSize(width: 100, height: 100)
//        createTheView()
    }
    

    private func createTheView() {

        let xCoord = self.view.bounds.width / 2 - 165
        let yCoord = self.view.bounds.height / 2 - 250
        let width = self.view.bounds.width / 1.25
        let height = self.view.bounds.height / 2
        let centeredView = UIView(frame: CGRect(x: xCoord, y: yCoord, width: width, height: height))
        centeredView.backgroundColor = .blue
        self.view.addSubview(centeredView)
    }

}
