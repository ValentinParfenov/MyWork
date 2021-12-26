//
//  CartViewController.swift
//  GraduateWork
//
//  Created by Валентин on 25.10.2021.
//

import Foundation
import UIKit

class CartController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var SumPriceLabel: UILabel!
    @IBOutlet weak var FinallyLabel: UILabel!
    
    let realmManager = RealmManager()
    let productList = ProductListRealm()
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTotalSum()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmManager.items = realmManager.realm.objects(ProductListRealm.self)
    }

    func updateTotalSum() {
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(assignTotalSumToLabel), userInfo: nil, repeats: true)
    }

    @objc func assignTotalSumToLabel() {
        SumPriceLabel.text = "\(outputFinalPrice ())₽"
    }
    
    func outputFinalPrice() -> Int {
        let arrayPrices = realmManager.items.value(forKey: "price") as! NSArray
        let priceToDouble = arrayPrices.compactMap{Double($0 as! Substring)}
        let priceToInt = priceToDouble.compactMap{Int($0)}
        let finalSumPrice = priceToInt.reduce(0, +)
        return finalSumPrice
    }
}

extension CartController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if realmManager.items.count != 0 {
            return realmManager.items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let item = realmManager.items[indexPath.row]
        cell.goodsImageView.layer.cornerRadius = 5
        cell.fillTableViewCart(item)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realmManager.deletePurchase(tableView, forRowAt: indexPath)
        }
    }
}

