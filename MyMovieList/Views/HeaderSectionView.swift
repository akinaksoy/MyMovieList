//
//  HeaderSectionView.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import SnapKit
import Kingfisher
class HeaderSectionView: UIView {

    private let detailButton : UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonColor, .white)
        button.layer.borderColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonLabelLayerColor, .white).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let watchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add Watch List", for: .normal)
        button.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonColor, .white)
        button.layer.borderColor = UIColor.generalColor(primaryColor: Constants.Colors.buttonLabelLayerColor, .white).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        stackView.addArrangedSubview(watchButton)
        stackView.addArrangedSubview(detailButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public func configure(with model: Movie){
        guard let modelPath = model.poster_path else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(modelPath)") else {return}
        KF.url(url).set(to: headerImageView)
    }
    private func configureDesign() {
        addSubview(headerImageView)
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        watchButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        detailButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
    }
}
