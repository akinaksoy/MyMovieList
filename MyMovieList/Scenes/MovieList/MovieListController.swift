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
        case popular = 0
        case topRated = 1
        case upcoming = 2
        case nowPlaying = 3
    }
    let sectionMovies : [String] = ["Popular","Top Rated","Upcoming","Now Playing"]
    let viewModel = MovieListViewModel()
    var popularMovies : [Movie] = [Movie]()
    var topRatedMovies : [Movie] = [Movie]()
    var upcomingMovies : [Movie] = [Movie]()
    var nowPlayingMovies : [Movie] = [Movie]()
    lazy var movieTableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        table.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        table.tableHeaderView = HeaderSectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 420))
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionMovies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.didTapDelegate = self
        
        switch indexPath.section {
        case Sections.popular.rawValue :
            viewModel.fetchMovies(url: APIConstants.URL.moviePopularURL) { results in
                switch results {
                case.success(let movies) :
                    self.popularMovies = movies
                    cell.configure(with: self.popularMovies)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.topRated.rawValue :
            viewModel.fetchMovies(url: APIConstants.URL.movieTopratedURL) { results in
                switch results {
                case.success(let movies) :
                    self.topRatedMovies = movies
                    cell.configure(with: self.topRatedMovies)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.upcoming.rawValue :
            viewModel.fetchMovies(url: APIConstants.URL.movieUpcomingURL) { results in
                switch results {
                case.success(let movies) :
                    self.upcomingMovies = movies
                    cell.configure(with: self.upcomingMovies)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.nowPlaying.rawValue :
            viewModel.fetchMovies(url: APIConstants.URL.movieNowPlayingURL) { results in
                switch results {
                case.success(let movies) :
                    self.nowPlayingMovies = movies
                    cell.configure(with: self.nowPlayingMovies)
                case .failure(let error) :
                    print(error)
                }
            }
        default :
            return UITableViewCell()
        }
        
        
        return cell
    }
    // her cellin boyutları
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = UIColor.generalColor(primaryColor: Constants.Colors.cellLayerLabelColor, .white)
       
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionMovies[section]
    }
}

extension MovieListController : MovieCollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: MovieListTableViewCell, view: Movie) {
        DispatchQueue.main.async { [weak self ] in
            let vc = MovieDetailViewController()
            vc.configureDetail(model: view)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
