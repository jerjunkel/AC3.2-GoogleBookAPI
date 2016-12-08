//
//  Book.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/3/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class Book{
    let id: String
    let link: String
    let title: String
    let subtile: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let pageCount: Int
    let categories: [String]
    let avgRating: Int
    let thumbnail: String
    let retailPrice: Double
    
    init?(with json: [String:AnyObject]){
        guard let volumeInfo = json["volumeInfo"] as? [String:AnyObject] else { return nil}
        self.id  = json["id"] as? String ?? ""
        self.link = json["selfLink"] as? String ?? ""
        self.title = volumeInfo["title"] as? String ?? ""
        self.subtile = volumeInfo["subtitle"] as? String ?? ""
        self.authors  = volumeInfo["authors"] as? [String] ?? [""]
        self.publisher = volumeInfo["publisher"] as? String ?? ""
        self.publishedDate = volumeInfo["publishedDate"] as? String ?? ""
        self.description = volumeInfo["description"] as? String ?? ""
        self.pageCount = volumeInfo["pageCount"] as? Int ?? 0
        self.categories = volumeInfo["categories"] as? [String] ?? [""]
        self.avgRating = volumeInfo["averageRating"] as? Int ?? 0
        self.thumbnail = volumeInfo["imageLinks"]?["smallThumbnail"] as? String ?? ""
        self.retailPrice = json["retailPrice"]?["amount"] as? Double ?? 0.0
    }
    
    static func makeBookObjects(from data: Data) -> [Book]?{
        var books: [Book] = []
        do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],let results = json["items"] as? [[String:AnyObject]] else {return nil}
            for book in results{
                if let bookObj = Book(with: book) {
                    books.append(bookObj)
                }else{
                    continue
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        return books
    }
    
    static func makeBookObject(from data: Data) -> Book?{
        do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {return nil}
            if let bookObj = Book(with: json) {
                return bookObj
            }
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
}
