//
//  Roadmap.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/25.
//

import UIKit
import Alamofire

class RoadmapApi {
    static let shard = RoadmapApi()
    
    //전체 코스 호출
    public func getCourseList(completionHandler: @escaping (Result<[Course],Error>) -> Void){
//    private func getCourseList(){
        let url = Contnets.BASE_URL + "/api/getAllcourseList"
        AF.request(url, method: .get, parameters: nil)
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
}
