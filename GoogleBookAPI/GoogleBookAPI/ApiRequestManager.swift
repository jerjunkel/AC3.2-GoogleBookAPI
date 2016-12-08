//
//  ApiRequestManager.swift
//  GoogleBookAPI
//
//  Created by Jermaine Kelly on 12/3/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation
import UIKit



class ApiRequestManager{
    static let manager: ApiRequestManager = ApiRequestManager()
    private init(){}
    
    func getData(from endpoint:String, completion: @escaping (Data)->()){
        guard let url = URL(string: endpoint) else { return }
        let session: URLSession = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print("Error \(error?.localizedDescription)")
            }
            
            if response != nil{
                if let responseCode = response as? HTTPURLResponse{
                    print(responseCode.statusCode)
                }
            }
            
            if let validData = data {
                completion(validData)
            }
            
            }.resume()
    }
    
    func getImage(for book:String, completion: @escaping (UIImage)->Void){
        let noCurlCover = book.replacingOccurrences(of: "&edge=curl", with: "")
        getData(from: noCurlCover) { (data) in
            var bookImage: UIImage = UIImage()
            if let image = UIImage(data: data){
                bookImage = image
                completion(bookImage)
            }
        }
    }
}
