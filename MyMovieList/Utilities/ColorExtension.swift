//
//  ColorExtension.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
import UIKit

extension UIColor{
    static func generalColor(primaryColor : UIColor?,_ alternativeColor : UIColor) -> UIColor {
        if let color = primaryColor {
            return color
        }
        else {
            return alternativeColor
        }
    }
}
