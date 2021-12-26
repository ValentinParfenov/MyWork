//
//  CollectionViewController.swift
//  GraduateWork
//
//  Created by Валентин on 05.11.2021.
//

import Foundation
import UIKit

class ProductListController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var subCategory: SubCategory!
    var productsInfo: [ProductInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadCategoryList().loadProductInfo (id: self.subCategory.id) { product in
            self.productsInfo = product
            self.collectionView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendGoodsData",
           let productInfoSender = sender as? ProductInfo,
           let vc = segue.destination as? ProductController {
               vc.productInfo = productInfoSender
           }
    }
}
    

extension ProductListController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsInfo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let productCollection = productsInfo[indexPath.row]
        cell.picturesCollection.layer.cornerRadius = 5
        cell.fillCollectionCell(collection: productCollection)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sendGoodsData", sender: productsInfo[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height/3
        let width = collectionView.bounds.width/2
        return CGSize(width: width, height: height)
    }
}
