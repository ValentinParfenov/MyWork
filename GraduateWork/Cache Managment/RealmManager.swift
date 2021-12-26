//
//  RealmManager.swift
//  GraduateWork
//
//  Created by Валентин on 26.10.2021.
//
import UIKit
import RealmSwift

class ProductListRealm: Object {
    @Persisted dynamic var sortOrder = ""
    @Persisted dynamic var descriptionn  = ""
    @Persisted dynamic var mainImage = ""
    @Persisted dynamic var name = ""
    @Persisted dynamic var size = ""
    @Persisted dynamic var colorName = ""
    @Persisted dynamic var price = ""
}

class RealmManager {
    let realm = try! Realm()
    var data = [ProductListRealm]()
    var items: Results<ProductListRealm>!

    
    func addPurchase(name: String, price: String, colorName: String, image: String, size: String) {
        let productsListRealm = ProductListRealm()
        productsListRealm.name = name
        productsListRealm.price = price
        productsListRealm.colorName = colorName
        productsListRealm.mainImage = image
        productsListRealm.size = size
        try! self.realm.write {
            self.realm.add(productsListRealm)
        }
    }

    func deletePurchase (_ tableView: UITableView, forRowAt indexPath: IndexPath) {
        try! self.realm.write {
            self.realm.delete(self.items[indexPath.row])
            tableView.reloadData()
        }
    }
}

