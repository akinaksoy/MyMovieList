//
//  ViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import UIKit
import SnapKit
class MovieListController: BaseViewController {

    enum Sections: Int {
        case trendingMovies = 0
        case popular = 1
        case upcoming = 2
        case topRated = 3
    }
    
    
    lazy var movieTableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        table.tableHeaderView = HeaderSectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 420))
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseService.requestAPI(APIConstants.URL.tvPopularURL, object: TvResponse.self) { result, error in
            print(result)
        }
        configureDesign()
        configureNavigationBar()
    }
    
    
    
    override func configureDesign() {
        super.configureDesign()
        
        view.addSubview(movieTableView)
        
        movieTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
}


extension MovieListController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
