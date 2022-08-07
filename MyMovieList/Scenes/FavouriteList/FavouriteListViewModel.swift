//
//  FavouriteListViewModel.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation

class FavouriteListViewModel {
    
    var movieList : [Movie] = [Movie]()
    
    func getFavouriteMovies() -> [Movie] {
        MovieDatabaseFunctions.fetchMovie { [self] results in
            switch results {
            case .success(let movies) :
                let movieModelList = prepareMovieModel(movieList: movies)
                self.movieList = movieModelList
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
        return movieList
    }
    
    private func prepareMovieModel(movieList : [MovieDB]) -> [Movie] {
        var modelList : [Movie] = [Movie]()
        for item in movieList {
            let movie = Movie(id: Int(item.id), media_type: item.media_type, original_name: item.original_name, original_title: item.original_title, poster_path: item.poster_path, overview: item.overview, vote_count: Int(item.vote_count), release_date: item.release_date, vote_average: item.vote_average)
            modelList.append(movie)
        }
        return modelList
    }
    
}
