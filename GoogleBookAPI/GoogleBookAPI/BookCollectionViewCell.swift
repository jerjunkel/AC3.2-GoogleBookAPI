//
//  BookCollectionViewCell.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/4/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    var book: Book!{
        didSet{
            setupCell()
        }
        
    }
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func setupCell(){
        ApiRequestManager.manager.getImage(for: self.book.thumbnail){ (image) in
            DispatchQueue.main.async {
                self.coverImageView.image = image
                print("Book Set")
            }
        }
        
        cellView.layer.masksToBounds = true
        cellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cellView.layer.shadowOpacity = 1
        self.backgroundColor = .red
        self.setNeedsDisplay()

        
    }
}
