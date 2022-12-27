//
//  User.swift
//  RecipeApp
//
//  Created by moh on 26/12/2022.
//

import Foundation
import UIKit

struct User: Encodable,Decodable{
    var userId : String
    var userName : String
    var userPassword: String
    var userBio: String
    var userImage: String
}
