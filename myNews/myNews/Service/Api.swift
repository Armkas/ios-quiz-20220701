//
//  Api.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/28.
//

import Foundation

final class Api {
    static let shared = Api()
}

extension Api {

    // Rest api没有最endpoint 对应 能对应更多不同api最好
    func getData(_ completion: @escaping ([Section]?, Error?) -> Void)  {
        guard let url = URL(string: "https://deeplink.dev.n8s.jp/quiz/followables.json") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("API Error =", error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            switch response.statusCode {
            case 200:
                print("API OK, status: ", response.statusCode)
                guard let data = data else {
                    print("API Get NO Data")
                    return
                }
                do {
                    let data = try JSONDecoder().decode(Sections.self, from: data)
                    print("API Get Data successful")
                    completion(data.sections, nil)
                } catch {
                    print("Error", error.localizedDescription)
                    completion(nil, error)
                }
            default:
                print("API Fail, status: ", response.statusCode)
            }
        }.resume()
    }
}
