//
//  BookDetailTableViewController.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/4/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BookDetailTableViewController: UITableViewController {
    var book: Book!
    var bookSelfLink: String = ""{
        didSet{
//            ApiRequestManager.manager.getData(from: self.bookSelfLink) { (data) in
//                self.book = Book.makeBookObject(from: data)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//        
//                }
//            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        self.title = "About this book"
        self.tableView.allowsSelection = false
        self.tableView.separatorInset.left = 0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.showsVerticalScrollIndicator = false
        
        
        ApiRequestManager.manager.getData(from: self.bookSelfLink) { (data) in
            self.book = Book.makeBookObject(from: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // guard let book = self.book else { print("No books") continue}
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookHeaderCell", for: indexPath) as! BookHeaderTableViewCell

            cell.book = self.book
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookDescriptionCell", for: indexPath) as! BookDescriptionTableViewCell
            cell.book = self.book
            return cell
        }
    }

    
 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
