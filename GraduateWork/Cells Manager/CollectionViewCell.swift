//
//  CollectionViewCell.swift
//  GraduateWork
//
//  Created by Валентин on 31.10.2021.
//
import Foundation
import UIKit
import Alamofire

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var priceGoodsListLabel: UILabel!
    @IBOutlet weak var picturesCollection: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    
    func fillCollectionCell(collection: ProductInfo) {
        self.nameProductLabel.text = collection.name
        self.priceGoodsListLabel.text = "\(Double(collection.price) ?? 0)₽"
        let collectionImage = "https://blackstarshop.ru/\(collection.mainImage)"
        
        AF.request(collectionImage, method: .get).response { response in
            if let dataC = response.data {
            let image = UIImage(data: dataC)
                DispatchQueue.main.async {
                    if let imageData = image?.jpegData(compressionQuality: 1.0) {
                    self.picturesCollection.image = UIImage(data : imageData)
                    } else {
                        self.picturesCollection.image = UIImage(named: "NoImageProduct")
                    }
                }
            } else {print("error")}
        }
//        prepareForReuse()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        picturesCollection?.image = nil
    }
}
