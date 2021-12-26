//
//  CategoryInfo.swift
//  GraduateWork
//
//  Created by Валентин on 19.10.2021.
//

import Foundation
import UIKit

struct Category {
    let name: String
    let sortOrder: String
    let iconImage: String
    var subcategories: [SubCategory]

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let iconImage = data["iconImage"] as? String,
            let jsonSubcategories = data["subcategories"] as? [NSDictionary]
        else { return nil }

        self.name = name
        self.sortOrder = sortOrder
        self.iconImage = iconImage

        var subcategories: [SubCategory] = []

        for loopSubCategory in jsonSubcategories {
            if let subCategory = SubCategory(data: loopSubCategory) {
                subcategories.append(subCategory)
            }
        }

        self.subcategories = subcategories
    }
}

struct SubCategory {
    let id: String
    let sortOrder: String
    let iconImage: String
    let name: String
    let type: String

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let iconImage = data["iconImage"] as? String,
            let id = data["id"] as? String,
              let type = data["type"] as? String
        else { return nil }
        
        self.name = name
        self.sortOrder = sortOrder
        self.iconImage = iconImage
        self.id = id
        self.type = type
    }
}

struct ProductInfo {
    var name: String
    let descriptionn: String
    var colorName: String
    let colorImageURL: String
    var mainImage: String
    let productImages: [ProductImage]
    let productOffer: [ProductOffer]
    let recommendedProductIDs: [String]
    let instagramPhotos: [String]
    var price: String

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
              let descriptionn = data["description"] as? String,
              let colorName = data["colorName"] as? String,
              let colorImageURL = data["colorImageURL"] as? String,
              let mainImage = data["mainImage"] as? String,
              let jsonProductImages = data["productImages"] as? [NSDictionary],
              
              let jsonOffers = data["offers"] as? [NSDictionary],
              let recommendedProductIDs = data["recommendedProductIDs"] as? [String],
              let instagramPhotos = [] as? [String],
              let price = data["price"] as? String
        else {
            return nil
        }

        self.name = name
        self.descriptionn = descriptionn
        self.colorName = colorName
        self.colorImageURL = colorImageURL
        self.mainImage = mainImage
        
        var productImages: [ProductImage] = []
        for loopProductPictures in jsonProductImages {
            if let picProduct = ProductImage(data: loopProductPictures) {
                productImages.append(picProduct)
            }
        }
        self.productImages = productImages
        
        var offers: [ProductOffer] = []
        for loopProductOffers in jsonOffers {
            if let offersProduct = ProductOffer(data: loopProductOffers) {
                offers.append(offersProduct)
            }
        }
        self.productOffer = offers
    
        self.recommendedProductIDs = recommendedProductIDs
        self.instagramPhotos = instagramPhotos
        self.price = price
    }
}


struct ProductImage {
    let imageURL: String
    let sortOrder: String
    
    init?(data: NSDictionary) {
        guard let imageURL = data["imageURL"] as? String,
            let sortOrder = data["sortOrder"] as? String
        else { return nil }
        
        self.imageURL = imageURL
        self.sortOrder = sortOrder
    }
}

struct ProductOffer {
    let size: String
    let productOfferID: String
    let quantity: String
    
    init?(data: NSDictionary) {
        guard let size = data["size"] as? String,
              let productOfferID = data["productOfferID"] as? String,
              let quantity = data["quantity"] as? String
        else { return nil }
        self.size = size
        self.productOfferID = productOfferID
        self.quantity = quantity
    }
}
