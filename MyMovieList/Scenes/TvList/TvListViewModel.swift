//
//  TvListViewModel.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
class TvListViewModel {
    
    func fetchTvSeries(url : String,completion : @escaping(Result<[Tv],Error>) -> Void) {
        BaseService.requestAPI(url, object: TvResponse.self) { results in
            switch results {
            case .success(let result) :
                let popularMovies = result.results
                completion(.success(popularMovies))
            case .failure(let error) :
                completion(.failure(error))
            }
            
        }
    }
    
    
}
