//
//  SizeCollectionCell.swift
//  GraduateWork
//
//  Created by Валентин on 05.12.2021.
//

import Foundation
import UIKit

class SizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    var productController: ProductController?
    
    func setSizeText (sizeProduct: String) {
        self.sizeLabel.text = sizeProduct
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 0.5)
                }
                self.productController?.sizeSelectHandler(text: self.sizeLabel.text ?? "")
            }
            else {
                UIView.animate(withDuration: 0.5) {
                     self.backgroundColor = .quaternarySystemFill
                }
            }
        }
    }
}
