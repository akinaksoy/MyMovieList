//
//  BaseViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Constants.Colors.navigationBarColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.titleColor]
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.tintColor = Constants.Colors.titleColor
    }
    
    func configureDesign() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    

}
