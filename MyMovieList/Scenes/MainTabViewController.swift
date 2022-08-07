//
//  MainTabViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieVC = UINavigationController(rootViewController: MovieListController())
        let tvVC = UINavigationController(rootViewController: TvListViewController())
        let favouriteVC = UINavigationController(rootViewController: FavouriteListViewController())
        movieVC.tabBarItem.image = UIImage(systemName: "house")
        movieVC.title = "Movies"
        tvVC.tabBarItem.image = UIImage(systemName: "person.fill")
        tvVC.title = "TVs"
        favouriteVC.tabBarItem.image = UIImage(systemName: "person.fill")
        favouriteVC.title = "Favourites"
        tabBar.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.navigationBarColor, .black)
        tabBar.tintColor = UIColor.generalColor(primaryColor: Constants.Colors.titleColor, .yellow)
        tabBar.unselectedItemTintColor = UIColor.generalColor(primaryColor: Constants.Colors.titleColor, .yellow).withAlphaComponent(0.5)
        setViewControllers([movieVC, tvVC,favouriteVC], animated: true)
    }
    

}
