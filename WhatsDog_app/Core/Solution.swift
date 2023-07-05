//
//  Solution.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import Foundation

class Solution {
    
    weak var user: User?
    var result = Dogs
    
    func match(imt: Double?, height: Int?, color: HairColor?) -> Dog {
        
        matchWith(imt)
        
        matchWith(height)
        
        matchWith(color)
        
        let finishDogs = sortedDogs()
        
        return finishDogs[Int.random(in: 0...finishDogs.count - 1)]
    }
    
    private func matchWith(_ imt: Double?) {
        guard let imt = imt else { return }
        
        switch imt {
        case let x where x < 18.5               : result = result.map {if $0.lifestyle == .superActive {$0.setupCount()}; return $0 }
        case let x where 18.5 <= x && x < 24.9  : result = result.map {if $0.lifestyle == .active {$0.setupCount()}; return $0}
        case let x where 25 <= x && x < 29.9    : result = result.map {if $0.lifestyle == .moderatelyActive {$0.setupCount()}; return $0}
        case let x where 30 <= x && x < 34.9    : result = result.map {if $0.lifestyle == .sedentary {$0.setupCount()}; return $0}
        case let x where 35 <= x                : result = result.map {if $0.lifestyle == .passive {$0.setupCount()}; return $0}
            
        default: break
        }
        
    }
    
    private func matchWith(_ height: Int?) {
        guard let height = height else { return }
        
        switch height {
        case 0...140  : result = result.map {if $0.size == .extraSmall {$0.setupCount()}; return $0 }
        case 141...155: result = result.map {if $0.size == .small {$0.setupCount()}; return $0 }
        case 156...170: result = result.map {if $0.size == .medium {$0.setupCount()}; return $0 }
        case 171...185: result = result.map {if $0.size == .big {$0.setupCount()}; return $0 }
        case 186...250: result = result.map {if $0.size == .extraBig {$0.setupCount()}; return $0 }
        default: break
        }
    }
    
    private func matchWith(_ hairColor: HairColor?) {
        guard let hairColor = hairColor else { return }
        result = result.map {if $0.mostPopularColor == hairColor {$0.setupCount()}; return $0}
    }
    
    private func findMaxScore() -> Int {
        var count = 0
        for dog in result {
            if dog.score > count {
                count = dog.score
            }
        }
        return count
    }
    
    private func sortedDogs() -> [Dog] {
        let count = findMaxScore()
        var finish = [Dog]()
        for dog in 0..<result.count {
            if result[dog].score == count {
                finish.append(result[dog])
            }
        }
        return finish
    }
}



