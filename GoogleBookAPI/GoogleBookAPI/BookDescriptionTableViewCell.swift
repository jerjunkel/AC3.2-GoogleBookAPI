//
//  BookDescriptionTableViewCell.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/5/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BookDescriptionTableViewCell: UITableViewCell {
    var book:Book!{
        didSet{
            guard let book = self.book else {return}
            let attrStr = try! NSAttributedString(
                data: book.description.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                           NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!],
                documentAttributes: nil)
            self.bookDescription?.attributedText = attrStr
        }
    }
    @IBOutlet weak var bookDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
