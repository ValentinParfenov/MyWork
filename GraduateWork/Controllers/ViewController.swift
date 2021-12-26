//
//  UIViewController.swift
//  GraduateWork
//
//  Created by Валентин on 14.11.2021.
//

import UIKit

class SizeAndColorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainView: UIView!
    var sizes = ["XS", "S", "M", "L" /*"XL", "XXL", "Fat motherfucker"*/]
    var colors = ["Blue", "White", "Green", "Black"]
    var colorSizeInfo: ProductInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.alpha = 10

//        view.heightAnchor.constraint(equalToConstant: CGFloat())
//     view.leadingAnchor.constraint(equalTo: ).isActive = true
//     view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//     view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//     view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        view.topAnchor.
        mainView.layer.cornerRadius = 20
        tableView.layer.cornerRadius = 20
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let loopCategory = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! AlertCell
        cell.colorLabel.text = colors[indexPath.row]
        cell.sizeLabel.text = sizes[indexPath.row]
        return cell
    }
}
