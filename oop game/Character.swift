//
//  Character.swift
//  oop game
//
//  Created by Jesus Lopez de Nava on 11/27/15.
//  Copyright © 2015 LodenaApps. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int
    private var _attackPower: Int
    private var _name: String
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
        
        set {
            _attackPower = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var isAlive: Bool {
        get {
            if _hp > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    init(hp: Int, attackPower: Int, name: String) {
        self._hp = hp
        self._attackPower = attackPower
        self._name = name
    }
    
    func gotHit(attackPower: Int) {
        self._hp -= attackPower
    }
    
}
