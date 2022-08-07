//
//  FavouriteListViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

class FavouriteListViewController: BaseViewController {

    let viewModel = FavouriteListViewModel()
    var favouriteList : [Movie] = [Movie]()
    lazy var tvTableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.favouriteList = self.viewModel.getFavouriteMovies()
            self.tvTableView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Constants.Colors.navigationBarColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.titleColor]
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.tintColor = Constants.Colors.titleColor
        title = "Favourites"
    }
    
    override func configureDesign() {
        super.configureDesign()
        
        view.addSubview(tvTableView)
        tvTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension FavouriteListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: favouriteList[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self ] in
            let vc = MovieDetailViewController()
            guard let movie = self?.favouriteList[indexPath.row] else {return}
            vc.configureDetail(model: movie)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
