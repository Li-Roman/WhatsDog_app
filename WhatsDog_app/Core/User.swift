//
//  User.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import Foundation
import UIKit

enum ZodiacSign {
    case aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
}

enum HairColor {
    
    case white
    case gold
    case lightBrown
    case redHairColor
    case brown
    case darkBrown
    case black
    case gray
}

enum Male {
    case male
    case female
}

class User {
    
    private(set) var avatar = UIImage(systemName: "person")!
    private(set) var male: Male?
    private(set) var name: String?
    private(set) var age: Int?
    private(set) var height: Int?
    private(set) var weight: Int?
    private(set) var hairColor: HairColor?
    private(set) var solution = Solution()
    
    var imt: Double? {
        if let weight = weight, let height = height {
            return Double(weight)/pow(Double(height), 2)
        } else {
            return nil
        }
    }
    
    func setupDefaultAvatar() {
        avatar = UIImage(systemName: "person")!
    }
    
    func setupAvatar(_ avatarImage: UIImage) {
        self.avatar = avatarImage
    }
    
    func setupMale(male: Male) {
        self.male = male
    }
    
    func setupName(name: String) {
        self.name = name
    }
    
    func setupAge(age: Int) {
        self.age = age
    }
    
    func setupHeight(height: Int) {
        self.height = height
    }
    
    func setupWeight(weight: Int) {
        self.weight = weight
    }
    
    func setupHairColor(hairColor: HairColor) {
        self.hairColor = hairColor
    }
    
    func match () -> (name: String, image: UIImage) {
        let result = solution.match(imt: self.imt, height: self.height, color: self.hairColor)
        return (name: result.name, image: result.image)
    }
}

