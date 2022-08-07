//
//  TvDatabaseFunctions.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 7.08.2022.
//

import Foundation
import CoreData
import UIKit

struct MovieDatabaseFunctions {
    
    enum DatabaseError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    static func saveMovie(model : Movie) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = MovieDB(context : context)

        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.overview = model.overview
        item.release_date = model.release_date
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)

        do {
            try context.save()

        } catch {
            print(error.localizedDescription)
        }
    }
    static func fetchMovie(completion : @escaping(Result<[MovieDB],Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<MovieDB>

        request = MovieDB.fetchRequest()
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }

    }
    static func deleteMovie(id: Int) -> Bool {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<MovieDB>
        request = MovieDB.fetchRequest()
        do {
            let titles = try context.fetch(request)
            for item in titles where item.id == id {
                context.delete(item)
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }

        return true
    }
    static func movieIsExist(movieId : Int) -> Bool {

        var careerList : [MovieDB] = [MovieDB]()
        fetchMovie { results in
            switch results {
            case .success(let movies) :
                careerList = movies
            case .failure(let error) :
                print(error)
            }
        }
        var isExist = false
        for item in careerList {
            if item.id == movieId {
                isExist = true
            }
        }

        return isExist
    }
}
