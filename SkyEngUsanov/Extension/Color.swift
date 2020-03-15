//
//  Color.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let skyeng1 = UIColor(red: 72/255, green: 158/255, blue: 220/255, alpha: 1)
    static let skyeng2 = UIColor(red: 144/255, green: 255/255, blue: 250/255, alpha: 1)
    static let skyeng3 = UIColor(red: 212/255, green: 248/255, blue: 253/255, alpha: 1)
    static let skyeng4 = UIColor(red: 161/255, green: 250/255, blue: 185/255, alpha: 1)
    static let skyeng5 = UIColor(red: 236/255, green: 117/255, blue: 58/255, alpha: 1)
    static let skyeng6 = UIColor(red: 162/255, green: 112/255, blue: 244/255, alpha: 1)
    static let skyeng7 = UIColor(red: 236/255, green: 114/255, blue: 174/255, alpha: 1)
    
    func randomColor() -> UIColor {
        let colors: [UIColor] = [.skyeng1, .skyeng2, .skyeng3, .skyeng4, .skyeng5, .skyeng6, .skyeng7]
        return colors[Int.random(in: 0..<6)]
    }
}
