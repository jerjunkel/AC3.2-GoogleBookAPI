//
//  BookResultsViewController.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/3/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BookResultsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    private let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    var searchResults: [Book] = []
    var endpoint: String = "https://www.googleapis.com/books/v1/volumes?q=bass"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GOOGLE BOOKS"
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.showsVerticalScrollIndicator = false
        searchBar.delegate = self
        searchBar.backgroundColor = .red
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white

        
    }
    
    
    //MARK:- CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        cell.book = searchResults[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 200)
    }
    
    
    //MARK:- Searchbar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "")
            getBooks(with: searchTerm)
        }
        self.searchBar.endEditing(true)
    }
    
    
    //MARK:- Utilities
    func getBooks(with title:String = "banana"){
        endpoint = "https://www.googleapis.com/books/v1/volumes?q=\(title)"
        ApiRequestManager.manager.getData(from: endpoint) { (data) in
            if let books = Book.makeBookObjects(from: data){
                self.searchResults = books
                DispatchQueue.main.async {
                    self.resultsCollectionView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookVc = segue.destination as? BookDetailTableViewController{
            if segue.identifier == "showBookDetail"{
                if let sender = sender as? UICollectionViewCell{
                    if let index = self.resultsCollectionView.indexPath(for: sender){
                        bookVc.bookSelfLink = searchResults[index.row].link
                        
                    }
                }
            }
        }
    }
    
    
    
    
}
