//
//  ProductCollectionCell.swift
//  GraduateWork
//
//  Created by Валентин on 12.11.2021.
//

import UIKit
import Alamofire

class ProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var productPictures: UIImageView!
    
    func fillProductCollectionPictures (product: ProductImage) {
        let productImage = "https://blackstarshop.ru/\(product.imageURL)"
        
        AF.request(productImage, method: .get).response { response in
            if let dataC = response.data {
            let image = UIImage(data: dataC)
                DispatchQueue.main.async {
                    if let imageData = image?.jpegData(compressionQuality: 1.0) {
                    self.productPictures.image = UIImage(data : imageData)
                    } else {print("error")}
                }
            } else {print("error")}
        }
//        prepareForReuse()
    }
    
    func setOneProductPicture (product: ProductInfo) {
        let productImage = "https://blackstarshop.ru/\(product.mainImage)"

        AF.request(productImage, method: .get).response { response in
            if let dataC = response.data {
            let image = UIImage(data: dataC)
                DispatchQueue.main.async {
                    if let imageData = image?.jpegData(compressionQuality: 1.0) {
                    self.productPictures.image = UIImage(data : imageData)
                    } else {
                        self.productPictures.image = UIImage(named: "NoImageProduct")
                    }
                }
            } else {print("error")}
        }
//        prepareForReuse()
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
         productPictures?.image = nil
     }
}
