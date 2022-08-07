//
//  ImageView.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
import UIKit
class ImageView {
    
    
    
    static let headerImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        imageView.layer.cornerRadius = 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.generalColor(primaryColor: Constants.Colors.cellLayerLabelColor, .black).cgColor
        return imageView
    }()
}
