//
//  TvDetailViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

class TvDetailViewController: BaseViewController {

    private var tv : Tv? = nil
    private let headerImage = ImageView.headerImage
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
        title = tv?.original_name
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
    
    func configureDetail(model : Tv) {
        self.tv = model
        guard let tvTitle = tv?.original_name, let releaseDateValue = tv?.first_air_date  else { return }
        guard let tvImage = tv?.poster_path else {return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(tvImage)") else {return }
        headerImage.sd_setImage(with: url, completed: nil)
        headerTitle.text = tvTitle
        releaseDate.text = "First Air Date : \(releaseDateValue)"
        overview.text = tv?.overview
    }

}
