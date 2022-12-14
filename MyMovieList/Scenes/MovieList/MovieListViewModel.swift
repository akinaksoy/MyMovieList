//
//  MovieListViewModel.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation

class MovieListViewModel {
    
    func fetchMovies(url : String,completion : @escaping(Result<[Movie],Error>) -> Void) {
        BaseService.requestAPI(url, object: MovieResponse.self) { results in
            switch results {
            case .success(let result) :
                let popularMovies = result.results
                completion(.success(popularMovies))
            case .failure(let error) :
                completion(.failure(error))
            }
            
        }
    }
    
    func getRandomMovie(completion : @escaping(Result<Movie,Error>) -> Void)  {
        BaseService.requestAPI(APIConstants.URL.moviePopularURL, object: MovieResponse.self) { results in
            switch results {
            case .success(let result) :
                let popularMovies = result.results
                let headerMovie = popularMovies[Int.random(in: 0..<popularMovies.count)]
                completion(.success(headerMovie))
            case .failure(let error) :
                completion(.failure(error))
            }
            
        }
    }
    
    
}
