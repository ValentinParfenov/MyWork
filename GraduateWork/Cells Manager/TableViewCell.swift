//
//  TableViewCell.swift
//  GraduateWork
//
//  Created by Валентин on 24.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageSubCategory: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    func fillSubCell (category: SubCategory) {
        self.subCategoryLabel.text = category.name
        
        DispatchQueue.main.async {
            let imageURL = NSURL(string: "https://blackstarshop.ru/\(category.iconImage)")
            if let imagedData = NSData(contentsOf: imageURL! as URL) {
                self.imageSubCategory.image = UIImage(data: imagedData as Data)
                    } else {
                        print("error")
                    }
            
            if category.iconImage == "" {
                self.imageSubCategory.image = UIImage(named: "NoCategoryImage")
            }
        }
//        prepareForReuse()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageSubCategory?.image = nil
    }
}
