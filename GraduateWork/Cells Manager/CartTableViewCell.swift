//
//  CartTableViewCell.swift
//  GraduateWork
//
//  Created by Валентин on 31.10.2021.
//
import Foundation
import UIKit
import Alamofire

class CartTableViewCell: UITableViewCell {
    
    let realmManager = RealmManager()
    
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var nameGoodsLabel: UILabel!
    @IBOutlet weak var sizeGoodsLabel: UILabel!
    @IBOutlet weak var colorGoodsLabel: UILabel!
    @IBOutlet weak var priceGoodsLabel: UILabel!

    func fillTableViewCart(_ sender: ProductListRealm) {
        self.nameGoodsLabel.text = sender.name
        self.priceGoodsLabel.text = "\(Double(sender.price) ?? 0)₽"
        self.colorGoodsLabel.text = sender.colorName
        self.sizeGoodsLabel.text = sender.size
        
        let productImage = "https://blackstarshop.ru/\(sender.mainImage)"
        
        AF.request(productImage, method: .get).response { response in
            guard let image = UIImage(data:response.data!) else {
                self.goodsImageView.image = UIImage(named: "NoImageProduct")
                return
            }
            DispatchQueue.main.async {
                let imageData = image.jpegData(compressionQuality: 1.0)
                self.goodsImageView.image = UIImage(data : imageData!)
            }
        }
//        prepareForReuse()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        goodsImageView?.image = nil
    }
}
