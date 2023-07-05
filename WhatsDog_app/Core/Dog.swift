//
//  Dog.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import Foundation
import UIKit

enum Lifestyle: Int {
    case superActive = 1 , active, moderatelyActive, sedentary, passive
}

enum Size: Int {
    case extraSmall = 1, small, medium, big, extraBig
}

class Dog {
    
    private(set) var codeName: String = ""
    private(set) var name: String = ""
    private(set) var lifestyle: Lifestyle = .active
    private(set) var mostPopularColor: HairColor = .white
    private(set) var size: Size = .extraSmall
    private(set) var image: UIImage
    private(set) var urlRequest: URL?
    
    private (set) var score: Int = 0
    
    init(image: UIImage, codeName: String, name: String, lifestyle: Lifestyle, mostPopularColor: HairColor, size: Size, urlRequst: URL?) {
        self.image = image
        self.codeName = codeName
        self.name = name
        self.lifestyle = lifestyle
        self.mostPopularColor = mostPopularColor
        self.size = size
        self.urlRequest = urlRequst
        self.score = 0
    }
    
    func setupCount() {
        score += 1
    }
}

let Dogs: [Dog] = [
    Dog(image: UIImage(named: "Английский_Мастиф" )!,codeName: "Английский_Мастиф"  ,name: "Английский Мастиф" , lifestyle: .moderatelyActive, mostPopularColor: .gold,       size: .big, urlRequst:        URL(string: "https://lapkins.ru/dog/angliyskiy-mastif/") ?? nil),
    Dog(image: UIImage(named: "Афганская_Борзая"  )!,codeName: "Афганская_Борзая"   ,name: "Афганская Борзая"  , lifestyle: .moderatelyActive, mostPopularColor: .gold,       size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/afganskaya-borzaya/") ?? nil),
    Dog(image: UIImage(named: "Бигль"             )!,codeName: "Бигль"              ,name: "Бигль"             , lifestyle: .active,           mostPopularColor: .brown,      size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/bigl/") ?? nil),
    Dog(image: UIImage(named: "Бишон_Фризе"       )!,codeName: "Бишон_Фризe"        ,name: "Бишон Фризe"       , lifestyle: .moderatelyActive, mostPopularColor: .white,      size: .small, urlRequst:      URL(string: "https://lapkins.ru/dog/bishon-frize/") ?? nil),
    Dog(image: UIImage(named: "Бордер_Колли"      )!,codeName: "Бордер_Колли"       ,name: "Бордер-Колли"      , lifestyle: .superActive,      mostPopularColor: .black,      size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/border-kolli/") ?? nil),
    Dog(image: UIImage(named: "Псовая_Борзая"     )!,codeName: "Псовая_Борзая"      ,name: "Псовая Борзая"     , lifestyle: .superActive,      mostPopularColor: .white,      size: .extraBig, urlRequst:   URL(string: "https://lapkins.ru/dog/russkaya-psovaya-borzaya/") ?? nil),
    Dog(image: UIImage(named: "Английский_Мастиф" )!,codeName: "Английский_Мастиф"  ,name: "Английский Мастиф" , lifestyle: .sedentary,        mostPopularColor: .gold,       size: .big, urlRequst:        URL(string: "https://lapkins.ru/dog/angliyskiy-mastif/") ?? nil),
    Dog(image: UIImage(named: "Йоркширский_Терьер")!,codeName: "Йоркширский_Терьер" ,name: "Йоркширский Терьер", lifestyle: .moderatelyActive, mostPopularColor: .lightBrown, size: .extraSmall, urlRequst: URL(string: "https://lapkins.ru/dog/yorkshirskiy-terer/") ?? nil),
    Dog(image: UIImage(named: "Комондор"          )!,codeName: "Комондор"           ,name: "Комондор"          , lifestyle: .moderatelyActive, mostPopularColor: .gray,       size: .big, urlRequst:        URL(string: "https://lapkins.ru/dog/komondor/") ?? nil),
    Dog(image: UIImage(named: "Лабрадор"          )!,codeName: "Лабрадор"           ,name: "Лабрадор"          , lifestyle: .superActive,      mostPopularColor: .gold,       size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/labrador-retriver/") ?? nil),
    Dog(image: UIImage(named: "Лайка"             )!,codeName: "Лайка"              ,name: "Лайка"             , lifestyle: .active,           mostPopularColor: .gray,       size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/zapadno-sibirskaya-layka/") ?? nil),
    Dog(image: UIImage(named: "Пудель"            )!,codeName: "Пудель"             ,name: "Пудель"            , lifestyle: .active,           mostPopularColor: .white,      size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/pudel/") ?? nil),
    Dog(image: UIImage(named: "Скай_Терьер"       )!,codeName: "Скай_Терьер"        ,name: "Скай-Терьер"       , lifestyle: .active,           mostPopularColor: .gray,       size: .small, urlRequst:      URL(string: "https://lapkins.ru/dog/skye-terrier/") ?? nil),
    Dog(image: UIImage(named: "Бассет_Хаунд"      )!,codeName: "Бассет_Хаунд"       ,name: "Бассет-Хаунд"      , lifestyle: .moderatelyActive, mostPopularColor: .brown,      size: .small, urlRequst:      URL(string: "https://lapkins.ru/dog/basset-khaund/") ?? nil),
    Dog(image: UIImage(named: "Такса"             )!,codeName: "Такса"              ,name: "Такса"             , lifestyle: .moderatelyActive, mostPopularColor: .darkBrown,  size: .small, urlRequst:      URL(string: "https://lapkins.ru/dog/taksa/") ?? nil),
    Dog(image: UIImage(named: "Хаски"             )!,codeName: "Хаски"              ,name: "Хаски"             , lifestyle: .superActive,      mostPopularColor: .gray,       size: .medium, urlRequst:     URL(string: "https://lapkins.ru/dog/sibirskiy-khaski/") ?? nil),
    Dog(image: UIImage(named: "Чихуа"             )!,codeName: "Чихуа"              ,name: "Чихуа"             , lifestyle: .sedentary,        mostPopularColor: .lightBrown, size: .extraSmall, urlRequst: URL(string: "https://lapkins.ru/dog/chikhuakhua/") ?? nil),
    Dog(image: UIImage(named: "Шпиц"              )!,codeName: "Шпиц"               ,name: "Шпиц"              , lifestyle: .moderatelyActive, mostPopularColor: .gold,       size: .extraSmall, urlRequst: URL(string: "https://lapkins.ru/dog/pomeranskiy-shpits/") ?? nil)
]

var some = Dogs

