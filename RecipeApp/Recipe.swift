//
//  Recipe.swift
//  RecipeApp
//
//  Created by moh on 24/12/2022.
//

import Foundation

struct Recipe: Decodable,Encodable,Comparable{
    static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.recipeName < rhs.recipeName
    }
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.recipeName == rhs.recipeName
    }
    
    static func calSort (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.calories > rhs.calories
    }
    
    static func carbSort (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.carb > rhs.carb
    }
    
    static func proteinSort (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.protein > rhs.protein
    }
    
    static func fatSort (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.fat > rhs.fat
    }
    
    var image: String;
    var recipeName: String;
    var category: String;
    
    var calories: Int;
    var protein: Int;
    var carb: Int;
    var fat: Int;
    
    var ingredients: String;
    var instructions: String;
}
