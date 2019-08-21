//
//  Extension.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import UIKit

extension UITableViewCell   {
    static var reuseIdentifier: String  {
        get {
            return "reuseIdentifier"
        }
    }
}


extension String    {
    func value() -> String {
        return self.isEmpty ? self : "\(self), "
    }
}

typealias ImageDownloadHandler = (UIImage?) -> Void

extension UIViewController {
    func fetchImage(from urlString: String, handler: @escaping ImageDownloadHandler) {
        DispatchQueue.global().async {
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                handler(UIImage(data: data))
            }
        }
    }
}
