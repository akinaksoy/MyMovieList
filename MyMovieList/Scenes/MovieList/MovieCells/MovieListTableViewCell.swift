//
//  ListTableViewCell.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit
import SnapKit

protocol MovieCollectionViewTableViewCellDelegate : AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell : MovieListTableViewCell, view:MovieDataModel)
}

class MovieListTableViewCell: UITableViewCell {
    static let identifier = "MovieListTableViewCell"
    
    private var movies : [Movie] = [Movie]()
    weak var didTapDelegate : MovieCollectionViewTableViewCellDelegate?
    lazy var movieCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .red)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .red)
        contentView.addSubview(movieCollectionView)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public func configure(with movies : [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            [weak self] in
            self?.movieCollectionView.reloadData()
        }
    }
}

extension MovieListTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = movies[indexPath.row].poster_path else {return UICollectionViewCell()}
        cell.configure(with: model)
        return cell
        
    }
    
}
