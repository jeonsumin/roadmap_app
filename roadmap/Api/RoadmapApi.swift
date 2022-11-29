//
//  Roadmap.swift
//  roadmap
//
//  Created by Terry on 2022/11/25.
//

import UIKit
import Alamofire

class RoadmapApi {
//    static let shard = RoadmapApi(url: <#String#>, method: <#HTTPMethod#>, parameters: <#Parameters#>)
    
    let url: String
    let method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders? = nil
    
    init(url: String, method: HTTPMethod, parameters: Parameters) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = nil
    }
    
    init(path:String, method:HTTPMethod,parameter:Parameters){
        url = Constants.BASE_URL + path
        self.method = method
        self.parameters = parameter
        self.headers = nil
    }
    init(path: String, method: HTTPMethod){
        url = Constants.BASE_URL + path
        self.method = method
        self.parameters = ["":""]
        self.headers = nil
    }
    
    //전체 코스 호출
    public func getCourseList(completionHandler: @escaping (Result<[Course],Error>) -> Void){
        let url = url
        AF.request(url, method: method, parameters: nil)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data ):
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Course].self, from: data)
                        completionHandler(.success(result))
                    }catch{
                        completionHandler(.failure(error))
                    }
                case .failure(let err):
                    completionHandler(.failure(err))
                }
            })
    }
    
    //지역 카테고리 호출
    public func getCetegoryList(completion: @escaping (Result<[Category], Error>) -> Void){
        AF.request(url,method: method,parameters: nil)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let value = try decoder.decode([Category].self, from: data)
                        completion(.success(value))
                    }catch(let error ){
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    public func getPlaceList(completion: @escaping (Result<[Place],Error>) -> Void) {
        AF.request(url,method: method,parameters: nil)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let value = try decoder.decode([Place].self, from: data)
                        completion(.success(value))
                    }catch(let e){
                        completion(.failure(e))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
