//
//  BookDetailController.swift
//  NYTBestSellerPractice
//
//  Created by Kelby Mittan on 2/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import SafariServices
import SCLAlertView

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
        
        modallView.menuButton.addTarget(self, action: #selector(linkButton(sender:)), for: .touchUpInside)
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
    
    @IBAction func linkButton(sender: UIButton) {
        //        print("button pressed")
        //
        //        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        //        present(alertController, animated: true)
        //
        //        let timesReviewAction = UIAlertAction(title: "NYT Review", style: .default) { [weak self] alertAction in
        //            let nytWebString = self?.selectedBook?.bookReviewLink
        //            guard let url = URL(string: nytWebString ?? "") else {
        //                if nytWebString == "" {
        //                    self?.showAlert(title: "Sorry", message: "The New York Times has yet to review this book.")
        //                }
        //                return
        //            }
        //            let safariNYTVC = SFSafariViewController(url: url)
        //            self?.present(safariNYTVC, animated: true)
        //        }
        //
        //        let googleInfoAction = UIAlertAction(title: "Google", style: .default) { [weak self] alertAction in
        //            let googleWebString = self?.googleBook.first?.volumeInfo.previewLink
        //            guard let url = URL(string: googleWebString ?? "") else {
        //                if googleWebString == "" {
        //                    self?.showAlert(title: "Sorry", message: "There is no preview of this book available on Google Books.")
        //                }
        //                return
        //            }
        //            let safariNYTVC = SFSafariViewController(url: url)
        //            self?.present(safariNYTVC, animated: true)
        //        }
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //
        //        alertController.addAction(timesReviewAction)
        //        alertController.addAction(googleInfoAction)
        //        alertController.addAction(cancelAction)
        
        let appearance = SCLAlertView.SCLAppearance(
            
            kCircleBackgroundTopPosition: 0,
            kCircleIconHeight: 180,
            showCircularIcon: true,
            circleBackgroundColor: .clear
        
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("NYT Review", backgroundColor: .gray) {
            print("first button")
            let nytWebString = self.selectedBook?.bookReviewLink
            guard let url = URL(string: nytWebString ?? "") else {
                if nytWebString == "" {
                    self.showAlert(title: "Sorry", message: "The New York Times has yet to review this book.")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self.present(safariNYTVC, animated: true)
        }
        alertView.addButton("Second Button", backgroundColor: .gray) {
            print("Second button tapped")
        }
        
        let image = UIImage.gif(name: "bookGIF2")!
        
        alertView.showCustom("Yo", subTitle: "whatup", color: .systemFill, icon: image)
//        alertView.showSuccess("", subTitle: "", circleIconImage: image)
        
    }
    
}


extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
