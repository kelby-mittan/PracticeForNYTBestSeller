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
    
    private var googleBook = [GoogleBook]()
    
    public var selectedBook: Book?
    public var booksIsbn: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .clear
//        view.alpha = 0.90
//        view.isOpaque = false
        
        modallView.backgroundColor = .clear

        loadBooks()
        updateBookImage()
//        self.preferredContentSize = CGSize(width: 100, height: 100)
//        createTheView()
        updateUI()
    }
    private var googleTitle = "" {
        didSet {
            print(googleTitle)
            updateUI()
        }
    }
    
    private func loadBooks() {
        
        guard let isbn = selectedBook?.primaryIsbn10 else {
            return
        }
        
        NYTAPIClient.getGoogleBooks(for: isbn) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let bookArr):
                self?.googleBook = bookArr
                self?.googleTitle = bookArr.first?.volumeInfo.title ?? "N/A"
                DispatchQueue.main.async {
                    self?.modallView.descriptionLabel.text = bookArr.first?.volumeInfo.description ?? "N/A"
                    self?.modallView.bookTitle.text = bookArr.first?.volumeInfo.title ?? "N/A"
                }
                dump(bookArr)
            }
        }
    }
    
    private func updateUI() {
        guard let book = selectedBook else {
            return
        }
//        if title.lowercased() == googleTitle.lowercased() {
//            print("THEYRE EQUAL")
//            DispatchQueue.main.async {
//                self.modallView.bookTitle.text = self.googleTitle
//            }
//
//        } else {
//            print("ERRRRRGHHHH")
//        }
        DispatchQueue.main.async {
            self.modallView.rankLabel.text = "Rank: \(book.rank)"
            self.modallView.byLine.text = book.contributor
            if book.rankLastWeek == 0 {
                self.modallView.weeksOnListLabel.text = "\(book.weeksOnList) weeks on list... Not ranked last week"
            } else {
                self.modallView.weeksOnListLabel.text = "\(book.weeksOnList) weeks on list. Ranked \(book.rankLastWeek) last week"
            }
        }
        
    }
    
    private func updateBookImage() {
        
        guard let book = selectedBook else { return }
        
        modallView.bookImageView.getImage(with: book.bookImage) {[weak self] (result) in
            switch result {
            case .failure:
                self?.modallView.bookImageView.image = UIImage(systemName: "photo")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.modallView.bookImageView.image = image
                }
            }
        }
        modallView.bookImageView.backgroundColor = .blue
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



