//
//  Binding.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation

class Dynamic<Type>   {
    typealias Listener = () -> Void
    
    var listener : Listener? = nil
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    var value : Type {
        didSet {
            DispatchQueue.main.async {
                self.listener?()                
            }
        }
    }
    
    init(_ value: Type) {
        self.value = value
    }
}
