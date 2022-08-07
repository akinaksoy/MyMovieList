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
    
    func configureNavigationBar(titleNav : String) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Constants.Colors.navigationBarColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.titleColor]
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.tintColor = Constants.Colors.titleColor
        title = titleNav
    }
    
    func configureDesign() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    func showAlert(title : String,message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
