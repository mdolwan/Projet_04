//
//  AddImage.swift
//  Instagrid
//
//  Created by Mohammad Olwan on 02/09/2021.
//

import Foundation
import UIKit

// Les extensions permettent d'ajouter des fonctionnalités qui n'existent pas à une classe déjà existante

extension UIImage {
    static func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
