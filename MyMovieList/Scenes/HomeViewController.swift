//
//  ViewController.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BaseService.requestAPI(APIConstants.URL.tvPopularURL, object: TvResponse.self) { result, error in
            print(result)
        }
    }
    


}

