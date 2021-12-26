//
//  CategoryCell.swift
//  GraduateWork
//
//  Created by Валентин on 19.10.2021.
//
import UIKit
import Foundation
import Alamofire

class CategoryCell: UITableViewCell {
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    func fillCell (category: Category) {
        self.nameCategoryLabel.text = category.name
        let imageURL = "https://blackstarshop.ru/\(category.iconImage)"
        
        AF.request(imageURL, method: .get).response { response in
            if let dataC = response.data {
            let image = UIImage(data: dataC)
                DispatchQueue.main.async {
                    if let imageData = image?.jpegData(compressionQuality: 1.0) {
                    self.imageCategory.image = UIImage(data: imageData)
                    } else {print("error")}
                }
            } else {print("error")}
        }
//        prepareForReuse()
    }
        override func prepareForReuse() {
            super.prepareForReuse()
            imageCategory?.image = nil
        }
}

