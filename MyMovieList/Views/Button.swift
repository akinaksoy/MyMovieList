//
//  Button.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
import UIKit
class Button {
    
    let button : UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.generalColor(primaryColor: Constants.Colors.buttonLabelLayerColor, .yellow), for: .normal)
        button.layer.borderColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonLabelLayerColor, .yellow).cgColor
        button.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonColor, .yellow)
        return button
    }()
    
    
    
}
