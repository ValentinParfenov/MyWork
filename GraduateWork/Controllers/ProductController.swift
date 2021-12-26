//
//  ProductVIewController.swift
//  GraduateWork
//
//  Created by Валентин on 31.10.2021.
//

import Foundation
import UIKit

class ProductController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewSize: UICollectionView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    @IBOutlet weak var colorProductLabel: UILabel!

    @IBAction func addToCartButtonHandler(_ sender: Any) {
        addToCart()
        setStandartAlert()
    }

    let realmManager = RealmManager()
    var productInfo: ProductInfo!
    var timer: Timer?
    var currentCellIndex = 0
    var sizeSaver = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewSize.delegate = self
        collectionViewSize.dataSource = self
        collectionView.backgroundColor = .quaternarySystemFill
        collectionViewSize.delaysContentTouches = false
  
        nameProductLabel.text = productInfo.name
        priceProductLabel.text = "\(Double(productInfo.price) ?? 0)₽"
        descriptionProductLabel.text = productInfo.descriptionn
        colorProductLabel.text = "Цвет: \(productInfo.colorName)"
    }
    
    func addToCart () {
        let productList = ProductListRealm()
        productList.name = self.productInfo.name
        productList.price = self.productInfo.price
        productList.colorName = self.productInfo.colorName
        productList.mainImage = self.productInfo.mainImage
        productList.size = sizeSelectHandler(text: sizeSaver)
        
        if productList.size == "" {
            setSizeAlert()
        } else {
        realmManager.addPurchase(name: productList.name, price: productList.price, colorName: productList.colorName, image: productList.mainImage, size: productList.size)
        }
    }

    // Alert для оповещения при добавлении в корзину и Alert при отсутствии выбора размера товара
    func setStandartAlert() {
        let alertView = UIAlertController(title: "Товар добавлен в корзину", message: nil, preferredStyle: .actionSheet)
        self.present(alertView, animated: true, completion: nil)
        timerAlert()
    }
    
    func setSizeAlert() {
        let alertView = UIAlertController(title: "Размер товара не выбран", message: "Выберите размер товара и добавьте в корзину", preferredStyle: .alert)
        self.present(alertView, animated: true, completion: nil)
        timerAlert()
    }

    func timerAlert() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(addToCartAlert), userInfo: nil, repeats: true)
    }

    @objc func addToCartAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sizeSelectHandler(text: String) -> String{
        sizeSaver = text
        return sizeSaver
    }
}

extension ProductController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewSize {
            return productInfo.productOffer.count
        }
        if productInfo.productImages.count == 0 {
            return 1
        } else {
            return productInfo.productImages.count
        }
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == self.collectionViewSize {
             let sizeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellSize", for: indexPath) as! SizeCollectionCell
             let sizeCollection = productInfo.productOffer[indexPath.row]
             sizeCell.layer.cornerRadius = 5
             sizeCell.setSizeText(sizeProduct: sizeCollection.size)
             sizeCell.productController = self
             
             return sizeCell
         } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ProductCollectionCell
             
             if productInfo.productImages.count == 0 {
                 cell.setOneProductPicture(product: productInfo)
             } else {
                 cell.fillProductCollectionPictures(product: productInfo.productImages[indexPath.row])
                 }
            return cell
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewSize {
            let heightSize = collectionView.bounds.height
            let widthSize = collectionView.bounds.width/5
            return CGSize(width: widthSize, height: heightSize)
        }
        let height = collectionView.bounds.height
        let width = collectionView.bounds.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViewSize {
            return 10
        }
        return 0
    }
}
