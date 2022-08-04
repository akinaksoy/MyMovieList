//
//  APICaller.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import Foundation

class APICaller {
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "?api_key=4e9def48a480fb4637caf940fa06f212"
    enum type : String {
    case movie = "movie"
    case tv = "tv"
    }
    
    enum movieCategory : String {
        case popular = "popular"
        case topRated = "top_rated"
        case latest = "latest"
        case upcoming = "upcoming"
        case nowPlaying = "now_playing"
    }
    
    enum tvCategory : String {
        case latest = "latest"
        case popular = "popular"
        case topRated = "top_rated"
        case onTheAir = "on_the_air"
        case airingToday = "airing_today"
    }
    
    
    fileprivate func prepareAPI(_ watchType : type,_ movieCategory : movieCategory?,_ tvCategory : tvCategory?) -> String {
        var url = baseURL
        switch watchType {
        case .movie:
            guard let category = movieCategory?.rawValue else { return url }
            url = "\(baseURL)movie/\(category)\(apiKey)"
        case .tv:
            guard let category = tvCategory?.rawValue else { return url }
            url = "\(baseURL)tv/\(category)\(apiKey)"
        }
        
        return url
    }
 }


struct APIConstants {
    
    struct URL{
        private static let apiCaller = APICaller()
        static var moviePopularURL : String {
            return apiCaller.prepareAPI(.movie, .popular, nil)
        }
        static var movieTopratedURL : String {
            return apiCaller.prepareAPI(.movie, .topRated, nil)
        }
        static var movieLatestURL : String {
            return apiCaller.prepareAPI(.movie, .latest, nil)
        }
        static var movieUpcomingURL : String {
            return apiCaller.prepareAPI(.movie, .upcoming, nil)
        }
        static var movieNowPlayingURL : String {
            return apiCaller.prepareAPI(.movie, .nowPlaying, nil)
        }
        static var tvPopularURL : String {
            return apiCaller.prepareAPI(.tv, nil, .popular)
        }
        static var tvLatestURL : String {
            return apiCaller.prepareAPI(.tv, nil, .latest)
        }
        static var tvTopratedURL : String {
            return apiCaller.prepareAPI(.tv, nil, .topRated)
        }
        static var tvOnTheAirURL : String {
            return apiCaller.prepareAPI(.tv, nil, .onTheAir)
        }
        static var tvAiringTodayURL : String {
            return apiCaller.prepareAPI(.tv, nil, .airingToday)
        }
        
    }
    
    
}
