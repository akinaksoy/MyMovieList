//
//  ViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import UIKit

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
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseService.requestAPI(APIConstants.URL.tvPopularURL, object: TvResponse.self) { result, error in
            print(result)
        }
        configureDesign()
    }
    
    
    override func configureDesign() {
        super.configureDesign()
        
    }
    
}


extension MovieListController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
