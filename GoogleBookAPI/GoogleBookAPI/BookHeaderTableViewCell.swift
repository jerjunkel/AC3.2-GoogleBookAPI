//
//  BookHeaderTableViewCell.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/4/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BookHeaderTableViewCell: UITableViewCell {
    var book: Book!{
        didSet{
            setupCell()
        }
    }
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var publisher: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.backgroundColor = .red
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupCell(){
        guard let book = self.book else {return}
        self.title.text = book.title
        self.authors.text = book.authors.reduce("",+)
        self.publisher.text = book.publisher
        ApiRequestManager.manager.getImage(for: book.thumbnail) { (image) in
            DispatchQueue.main.async {
                self.cover.image = image
                self.setNeedsDisplay()
                
            }
        }
    }
    
}
