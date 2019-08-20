//
//  Binding.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

class Dynamic<Type>   {
    
    var value : Type
    
    init(_ value: Type) {
        self.value = value
    }
}
