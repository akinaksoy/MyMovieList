//
//  TvTableViewCell.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

protocol TvCollectionViewTableViewCellDelegate : AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell : TvTableViewCell, view:Tv)
}

class TvTableViewCell: UITableViewCell {

    static let identifier = "TvTableViewCell"
    private var tvSeries : [Tv] = [Tv]()
    weak var didTapDelegate : TvCollectionViewTableViewCellDelegate?
    
    lazy var tvCollectionView : UICollectionView = {
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
        contentView.addSubview(tvCollectionView)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tvCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    public func configure(with tvSeries : [Tv]) {
        self.tvSeries = tvSeries
        DispatchQueue.main.async {
            [weak self] in
            self?.tvCollectionView.reloadData()
        }
    }
}


extension TvTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = tvSeries[indexPath.row].poster_path else {return UICollectionViewCell()}
        cell.configure(with: model)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tv = self.tvSeries[indexPath.row]
        self.didTapDelegate?.collectionViewTableViewCellDidTapCell(self, view: tv)
    }
    
}
