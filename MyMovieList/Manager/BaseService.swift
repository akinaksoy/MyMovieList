//
//  BaseServiceManager.swift
//  MyMovieList
//
//  Created by Akın Aksoy on 4.08.2022.
//

import Foundation
import Alamofire

public class BaseService {
    
    class func requestAPI<T>(_ url : String,object : T.Type, completion : @escaping(Result<T,Error>) -> Void) where T : Decodable {
        
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseData { (responseData) in
            guard let data = responseData.data else {return}

            do {
                let translationResult = try JSONDecoder().decode(T.self, from: data)
                completion(.success(translationResult as! T))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}
