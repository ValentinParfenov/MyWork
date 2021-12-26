//
//  LoadCategoryList.swift
//  GraduateWork
//
//  Created by Валентин on 19.10.2021.
//

import Foundation
import UIKit
import Alamofire

class LoadCategoryList {

    func loadCategory (completion: @escaping ([Category]) -> Void) {
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON { response in
            if let jsonCategories = response.value as? NSDictionary {
                var categories: [Category] = []

                for (_, loopCategory) in jsonCategories where loopCategory is NSDictionary {
                    if let category = Category(data: loopCategory as! NSDictionary) {
                        categories.append(category)
                    }
                }
                DispatchQueue.main.async {
                    completion(categories)
                }
            }
        }
    }
    
    func loadProductInfo (id: String, completion: @escaping ([ProductInfo]) -> Void) {
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)").responseJSON { response in
            if let jsonProduct = response.value as? NSDictionary {
                var productsInfo: [ProductInfo] = []

                for (_, loopProduct) in jsonProduct where loopProduct is NSDictionary {
                    if let product = ProductInfo(data: loopProduct as! NSDictionary) {
                        productsInfo.append(product)
                    }
                }
                DispatchQueue.main.async {
                    completion(productsInfo)
                }
            }
        }
    }
}
