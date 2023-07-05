//
//  Source.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

enum Gender: Int {
    case male = 1
    case female
}

class Friend {
    var name: String
    var gender: Gender
    var avatar: UIImage
    var resultBreed: String
    var resultImage: UIImage = UIImage(named: "finishDog")!
    
    init(name: String, gender: Gender, avatar: UIImage, resultBreed: String, resultImage: UIImage = UIImage(named: "finishDog")!) {
        self.name = name
        self.gender = gender
        self.avatar = avatar
        self.resultBreed = resultBreed
        self.resultImage = resultImage
    }
}

var Friends = Source().makeFrinds()
var FriendsWithGroups = Source().dogsTypeGroups()


class Source {
    
    private var friends = [Friend]()
    
    func makeFrinds() -> [Friend] {
        var friends = self.friends
        for i in 0...49 {
            friends.append(.init(name: Men[i],
                                 gender: .male,
                                 avatar: UIImage(named: "\(i+1)")!,
                                 resultBreed: Dogs[Int.random(in: 0...Dogs.count - 1)].name
                                ))
            friends.append(.init(name: Women[i],
                                 gender: .female,
                                 avatar: UIImage(named: "0\(i+1)")!,
                                 resultBreed: Dogs[Int.random(in: 0...Dogs.count - 1)].name
                                ))
        }
        
        friends = friends.map { friend in
            let image: UIImage = {
                return Dogs.first {$0.name == friend.resultBreed}!.image
            }()
            
            friend.resultImage = image
            return friend
        }
        friends = friends.shuffled()
        return friends
    }
    
    func dogsTypeGroups() -> [[Friend]] {
        var result = [[Friend]]()
        for dog in Dogs {
            // let arr = makeFrinds().filter {$0.resultBreed == dog.name}
            result.append(makeFrinds().filter {$0.resultBreed == dog.name})
        }
        
        for i in 0..<Dogs.count {
            print(result[i].count, result[i][0].resultBreed)
        }
        
        return result
    }
    
    func appendUser(user: Friend) {
        friends.append(user)
    }
}

