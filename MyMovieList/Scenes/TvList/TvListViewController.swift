//
//  TvListViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import UIKit

class TvListViewController: BaseViewController, TvCollectionViewTableViewCellDelegate {
    
    
    

    enum Sections: Int {
        case popular = 0
        case topRated = 1
        case on_the_air = 2
        case airing_today = 3
    }
    let sectionTvs : [String] = ["Popular","Top Rated","On The Air","Airing Today"]
    let viewModel = TvListViewModel()
    var popularTvSeries : [Tv] = [Tv]()
    var topRatedTvSeries : [Tv] = [Tv]()
    var onTheAirTvSeries : [Tv] = [Tv]()
    var airingTodayTvSeries : [Tv] = [Tv]()
    
    
    private var headerView : HeaderSectionView?
    let refreshControl = UIRefreshControl()
    lazy var tvTableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.generalColor(primaryColor: Constants.Colors.backgroundColor, .black)
        table.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.identifier)
        headerView = HeaderSectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 420))
        configureHeaderImage()
        table.tableHeaderView = headerView
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureDesign()
    }
    

    override func configureDesign() {
        super.configureDesign()
        view.addSubview(tvTableView)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
       
        tvTableView.addSubview(refreshControl)
        tvTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension TvListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTvs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvTableViewCell.identifier, for: indexPath) as? TvTableViewCell else {
            return UITableViewCell()
        }
        cell.didTapDelegate = self
        
        switch indexPath.section {
        case Sections.popular.rawValue :
            viewModel.fetchTvSeries(url: APIConstants.URL.tvPopularURL) { results in
                switch results {
                case.success(let tvSeries) :
                    self.popularTvSeries = tvSeries
                    cell.configure(with: self.popularTvSeries)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.topRated.rawValue :
            viewModel.fetchTvSeries(url: APIConstants.URL.tvTopratedURL) { results in
                switch results {
                case.success(let tvSeries) :
                    self.topRatedTvSeries = tvSeries
                    cell.configure(with: self.topRatedTvSeries)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.on_the_air.rawValue :
            viewModel.fetchTvSeries(url: APIConstants.URL.tvOnTheAirURL) { results in
                switch results {
                case.success(let tvSeries) :
                    self.onTheAirTvSeries = tvSeries
                    cell.configure(with: self.onTheAirTvSeries)
                case .failure(let error) :
                    print(error)
                }
            }
        case Sections.airing_today.rawValue :
            viewModel.fetchTvSeries(url: APIConstants.URL.tvAiringTodayURL) { results in
                switch results {
                case.success(let tvSeries) :
                    self.airingTodayTvSeries = tvSeries
                    cell.configure(with: self.airingTodayTvSeries)
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
        return sectionTvs[section]
    }
    
    func collectionViewTableViewCellDidTapCell(_ cell: TvTableViewCell, view: Tv) {
        DispatchQueue.main.async { [weak self ] in
            let vc = TvDetailViewController()
            vc.configureDetail(model: view)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TvListViewController {
    
    func configureHeaderImage() {
        viewModel.getRandomTv { result in
            switch result {
            case.success(let tv) :
                self.headerView?.configure(with: tv.poster_path ?? "")
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tvTableView.reloadData()
        configureHeaderImage()
        refreshControl.endRefreshing()
    }
}
