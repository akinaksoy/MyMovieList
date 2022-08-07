//
//  FavouriteTableViewCell.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import Kingfisher
class FavouriteTableViewCell: UITableViewCell {

    static let identifier = "FavouriteTableViewCell"
    
    let headerImageView = ImageView.init().headerImage
    let titleLabel = Label.init().headerTitleLabel
    let releaseDateLabel = Label.init().subTitleLabel
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.cellBackgroundColor, .red)
        
        configureDesign()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model : Movie) {
        guard let modelUrl = model.poster_path, let headerTitle = model.original_title, let releaseDate = model.release_date else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(modelUrl)") else {return}
        KF.url(url).set(to: headerImageView)
        titleLabel.text = headerTitle
        releaseDateLabel.text = releaseDate
    }
    
    func configureDesign(){
        contentView.addSubview(headerImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        
        headerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalTo(headerImageView.snp_rightMargin).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(16)
            make.left.equalTo(headerImageView.snp_rightMargin).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
    }
}
