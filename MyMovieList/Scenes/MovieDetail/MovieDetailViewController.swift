//
//  MovieDetailViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import SnapKit
import Kingfisher
class MovieDetailViewController: BaseViewController {

    
    private var movie : Movie? = nil
    
    private let headerImage = ImageView.headerImage
    
    let headerTitle = Label.headerTitleLabel
    let releaseDate = Label.subTitleLabel
    let overview = Label.contentTitle
    
    let addWatchListButton = Button.button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDesign()
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Constants.Colors.navigationBarColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.titleColor]
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.tintColor = Constants.Colors.titleColor
        title = movie?.original_name
    }
    
    override func configureDesign() {
        super.configureDesign()
        guard let id = movie?.id else {return}
        checkWatchList(id: id)
        
        view.addSubview(headerImage)
        view.addSubview(headerTitle)
        view.addSubview(releaseDate)
        view.addSubview(overview)
        
        view.addSubview(addWatchListButton)
        headerImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.width.equalToSuperview().inset(8)
            make.height.equalTo(300)
        }
        headerTitle.snp.makeConstraints { make in
            
            make.top.equalTo(headerImage.snp_bottomMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp_bottomMargin).offset(8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        overview.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp_bottomMargin).offset(16)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        addWatchListButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureDetail(model : Movie) {
        self.movie = model
        guard let movieTitle = movie?.original_title, let releaseDateValue = movie?.release_date  else { return }
        guard let movieImage = movie?.poster_path else {return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieImage)") else {return }
        KF.url(url).set(to: headerImage)
        headerTitle.text = movieTitle
        releaseDate.text = "Release Date : \(releaseDateValue)"
        overview.text = movie?.overview
    }
    
    func checkWatchList(id : Int) {
        
        let isExist = MovieDatabaseFunctions.movieIsExist(movieId: id)
        
        if isExist == false {
            addWatchListButton.setTitle("Add to Watchlist", for: .normal)
            addWatchListButton.addTarget(self, action: #selector(clickedAddWatchlistButton), for: .touchUpInside)
        } else {
            addWatchListButton.setTitle("Remove from Watchlist", for: .normal)
            addWatchListButton.addTarget(self, action: #selector(clickedRemoveWatchList), for: .touchUpInside)
        }
        
        
    }
    
    @objc func clickedAddWatchlistButton() {
        guard let model = movie else {return}
        MovieDatabaseFunctions.saveMovie(model: model)
        checkWatchList(id: model.id)
    }
    @objc func clickedRemoveWatchList() {
        guard let model = movie else {return}
        if MovieDatabaseFunctions.deleteMovie(id: model.id) {
            showAlert(title: "Success", message: "Movie Deleted from Watchlist")
        }
        checkWatchList(id: model.id)
    }

}
