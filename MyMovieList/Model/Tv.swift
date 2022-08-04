//
//  Tv.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import Foundation

struct TvResponse : Codable{
    let results : [Tv]
}

struct Tv : Codable {
    let id : Int
    let first_air_date : String?
    let original_name : String?
    let poster_path : String?
    let overview : String?
    let vote_count : Int
    let vote_average : Double

}
