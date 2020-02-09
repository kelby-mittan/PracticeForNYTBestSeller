//
//  BookListController.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Gemini

class BookListController: UIViewController {
    
    private let listView = CollectionView()
    
    private var books = [Book]() {
        didSet {
            DispatchQueue.main.async {
                self.listView.geminiCollectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = listView
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        listView.geminiCollectionView.alpha = 1
//        loadBooks()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.geminiCollectionView.dataSource = self
        listView.geminiCollectionView.delegate = self
        
        listView.collectionView.dataSource = self
        listView.collectionView.delegate = self
        
        listView.geminiCollectionView.backgroundColor = .systemGroupedBackground
        
        listView.geminiCollectionView.register(GeminiBookCell.self, forCellWithReuseIdentifier: "geminiBookCell")
        
        //        listView.collectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        loadBooks()
        
        addBackgroundGradient()
        
        //        listView.collectionView.gemini
        //            .customAnimation()
        //            .translation(x: 0, y: 50, z: 0)
        //            .rotationAngle(x: 0, y: 13, z: 0)
        //            .ease(.easeOutExpo)
        //            .shadowEffect(.fadeIn)
        //            .maxShadowAlpha(0.3)
        
        //            listView.geminiCollectionView.gemini
        //                .rollRotationAnimation()
        //                .degree(85)
        //                .rollEffect(.reverseSineWave)
        
        listView.geminiCollectionView.gemini
            .cubeAnimation()
            .cubeDegree(90)
//                    .alpha(0.15)
        
        
        //        listView.geminiCollectionView.gemini
        //        .pitchRotationAnimation()
        
        
    }
    
    private func loadBooks() {
        NYTAPIClient.getBooks(for: "hardcover-nonfiction") { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let bookArr):
                self.books = bookArr.books
            }
        }
    }
    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        listView.geminiCollectionView.backgroundView = collectionViewBackgroundView
        listView.geminiCollectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    
}


extension BookListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.75
        let itemHeight: CGFloat = maxSize.height * 0.70
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "geminiBookCell", for: indexPath) as? GeminiBookCell else {
            fatalError("could not deque cell")
        }
        
        print("selected")
        print("cell\(indexPath.row)")
        cell.selectedView.isHidden = true
        //cell.bookImageView.isHidden = true
        let bookDetailVC = BookDetailController()
        //        navigationController?.pushViewController(bookDetailVC, animated: true)
        let book = books[indexPath.row]
        bookDetailVC.selectedBook = book
    
        self.present(bookDetailVC, animated: true)
        
        listView.geminiCollectionView.alpha = 0.15
        cell.layoutIfNeeded()
        
    }
}

extension BookListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let geminiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "geminiBookCell", for: indexPath) as? GeminiBookCell else {
            fatalError("could not deque cell")
        }
        
        //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell else {
        //            fatalError("could not deque cell")
        //        }
        
        let book = books[indexPath.row]
        
        listView.geminiCollectionView.animateCell(geminiCell)
        geminiCell.backgroundColor = .systemBackground
        geminiCell.geminiDelegate = self
        geminiCell.configureCell(for: book)
        //        cell.configureCell(for: book)
        return geminiCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listView.geminiCollectionView.animateVisibleCells()
        listView.geminiCollectionView.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? GeminiBookCell {
            listView.geminiCollectionView.animateCell(cell)
        }
    }
    
}

extension BookListController: GeminiCellDelegate {
    func didLongPress(_ imageCell: GeminiBookCell) {
        print("delegate working")
        
        guard let indexPath = listView.geminiCollectionView.indexPath(for: imageCell) else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(alertController, animated: true)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteImageObject(indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
    
    private func deleteImageObject(indexPath: IndexPath) {
        books.remove(at: indexPath.row)
    }
}
