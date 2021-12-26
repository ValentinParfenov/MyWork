//
//  SubcategoryScreenController.swift
//  GraduateWork
//
//  Created by Валентин on 20.10.2021.
//

import Foundation
import UIKit

class SubCategoryListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data: Category!
    var timer: Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateSubTableView()
        showAlertViewForEmptySubcategories()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlertViewForEmptySubcategories() {
        if data.subcategories.count == 0 {
            let alertView = UIAlertController(title: "Подкатегории товаров отсутствуют", message: "Приносим извинения за доставленные неудобства. Команда BlackStar!", preferredStyle: .alert)
            self.present(alertView, animated: true, completion: {
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.selector), userInfo: nil, repeats: true)
            })
        } else {print("error")}
    }
    
    @objc func selector() {
        self.dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSubData",
           let subCategorySender = sender as? SubCategory,
           let vc = segue.destination as? ProductListController {
               vc.subCategory = subCategorySender
           }
    }
}

extension SubCategoryListController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.subcategories.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath) as! TableViewCell
        let loopSubCategory = data.subcategories[indexPath.row]
        cell.fillSubCell(category: loopSubCategory)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sendSubData", sender: data.subcategories[indexPath.row])
    }
    
    @objc func animateSubTableView() {
       tableView.reloadData()
       
       let cells = tableView.visibleCells
       let tableViewHeight = tableView.bounds.height
       var delay: Double = 0
       
       for cell in cells {
           cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
           
           UIView.animate(withDuration: 1.5,
                          delay: delay * 0.05,
                          usingSpringWithDamping: 0.8,
                          initialSpringVelocity: 0,
                          options: .curveEaseInOut,
                          animations: {
               cell.transform = CGAffineTransform.identity})
           delay += 1
       }
   }
}
