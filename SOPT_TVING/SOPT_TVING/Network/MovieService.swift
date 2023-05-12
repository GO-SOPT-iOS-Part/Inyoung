//
//  MovieService.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/12.
//

import Foundation

import Alamofire

final class MovieRequest {

    static let shared = MovieRequest()
    
    private(set) var getRecommendData: MovieResponse?
    
    private init() {}

    func getNowPlayingMovie(completion: @escaping (NetworkResult<Any>) -> Void) {

        let url = Config.base_url + "now_playing?api_key=\(Config.api_key)&language=en-US&page=1"
        let header: HTTPHeaders = ["Content-Type": "application/json"]

        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)

        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            case .failure:
                completion(.networkErr)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        dump(data)
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400, 409: return isValidData(data: data)
        case 500: return .serverErr
        default: return .networkErr
        }
    }

    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MovieResponse.self, from: data) else {
            return .pathErr
        }
        

        return .success(decodedData as Any)
    }

}
