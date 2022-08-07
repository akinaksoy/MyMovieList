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
    
    func getRandomTv(completion : @escaping(Result<Tv,Error>) -> Void)  {
        BaseService.requestAPI(APIConstants.URL.tvPopularURL, object: TvResponse.self) { results in
            switch results {
            case .success(let result) :
                let popularTVs = result.results
                let headerTv = popularTVs[Int.random(in: 0..<popularTVs.count)]
                completion(.success(headerTv))
            case .failure(let error) :
                completion(.failure(error))
            }
            
        }
    }
}
