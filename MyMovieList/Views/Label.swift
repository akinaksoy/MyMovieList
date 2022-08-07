//
//  Label.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
import UIKit
class Label {
    
    
    let headerTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor.generalColor(primaryColor: Constants.Colors.layerLabelColor, .white)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor.generalColor(primaryColor: Constants.Colors.layerLabelColor, .white)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let contentTitle : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = UIColor.generalColor(primaryColor: Constants.Colors.layerLabelColor, .white)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
}
