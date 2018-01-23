//
//  Api.swift
//  tomoki-ios-teach
//
//  Created by konojunya on 2018/01/23.
//  Copyright © 2018年 konojunya. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRouter {
    var path: String { get }
    var method: ApiMethod { get }
}

enum ApiMethod {
    case Get
    case Post
}

enum Result<T, E> {
    case success(T)
    case failure(E)
}


class Api {
    
    private var router: ApiRouter
    private var parameters: [String: Any] = []
    private var host: String {
        return "https://api.twitter"
    }
    
    private var request: URLRequest? {
        let baseUrl =  host + router.path
        guard let url: URL = .init(string: baseUrl) else {
            return nil
        }
        let request: URLRequest = .init(url: url)
        return request
    }
    
    private init(router: ApiRouter) {
        self.router = router
    }
    
    static func create(router: ApiRouter) -> Api {
        return .init(router: router)
    }
    
    func parameters(_ parameters: [String: Any]) -> Self {
        self.parameters = parameters
    }
    
    func request<T>(response: T) -> Result<T, Error> {
        Alamofire.request(request)
            .validate()
            .response { result, _ , _ in
                if let result = result {
                    return .success(T)
                } else {
                    
                }
            }
    }
}

extension Api {
    struct Feed {
        enum Router: ApiRouter {
            case tweet
            
            var path: String {
                switch self {
                case .tweet:
                    return "/tweet"
                }
            }
            
            var method: ApiMethod {
                switch self {
                case .tweet:
                    return .Get
                }
            }
        }
        
        static func getTweets() -> Result<[Tweet], Error> {
            let parameters = [String: Any]()
            parameters["id"] = 1
            return Api.create(router: Router.tweet)
                    .parameters(parameters)
                    .request()
        }
    }
}

struct Tweet Codable {
    var content: String
}
