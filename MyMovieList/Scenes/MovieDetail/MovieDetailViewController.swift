//
//  MovieDetailViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import SnapKit
class MovieDetailViewController: BaseViewController {

    
    private var movie : Movie? = nil
    
    lazy var headerImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        imageView.layer.cornerRadius = 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.generalColor(primaryColor: Constants.Colors.cellLayerLabelColor, .black).cgColor
        guard let movieImage = movie?.poster_path else {return UIImageView()}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieImage)") else {return UIImageView()}
        imageView.sd_setImage(with: url, completed: nil)
        return imageView
    }()
    
    let headerTitle = Label.headerTitleLabel
    let releaseDate = Label.subTitleLabel
    let overview = Label.contentTitle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDesign()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        title = movie?.original_name
    }
    
    override func configureDesign() {
        super.configureDesign()
        
        view.addSubview(headerImage)
        view.addSubview(headerTitle)
        view.addSubview(releaseDate)
        view.addSubview(overview)
        
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
    }
    
    func configureDetail(model : Movie) {
        self.movie = model
        guard let movieTitle = movie?.original_title, let releaseDateValue = movie?.release_date  else { return }
        headerTitle.text = movieTitle
        releaseDate.text = "Release Date : \(releaseDateValue)"
        overview.text = movie?.overview
    }
    

}
