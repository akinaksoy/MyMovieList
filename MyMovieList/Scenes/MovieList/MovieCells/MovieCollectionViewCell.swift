//
//  MovieCollectionViewCell.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import SnapKit
import SDWebImage
class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    private let posterImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(frame : CGRect){
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init(coder : NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public func configure(with model : String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
