//
//  Category.swift
//  RecipeApp
//
//  Created by moh on 26/12/2022.
//

import Foundation

struct Category : Encodable, Decodable, Comparable{
    static func < (lhs: Category, rhs: Category) -> Bool {
        lhs.categoryName < rhs.categoryName
    }
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.categoryName == rhs.categoryName
    }
    var categoryId : String
    var categoryName : String
}

