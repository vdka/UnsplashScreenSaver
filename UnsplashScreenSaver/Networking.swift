
import UIKit

struct Unsplash {

    static let base: String = "https://098e2ced.au.ngrok.io"

    static var clientKey: String = "REPLACE"

    static func request(_ endpoint: String, completion: @escaping (Any?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: Unsplash.base + endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(Unsplash.clientKey, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("v1", forHTTPHeaderField: "Accept-Version")

        return URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _, _ in

            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                completion(json)
            } else {
                completion(nil)
            }
        })
    }

    static func getRandom(completion: @escaping (Any?) -> Void) {
        Unsplash.request("/photos/random", completion: completion)?.resume()
    }

    static func getCollection(completion: @escaping (Any?) -> Void) {
        Unsplash.request("/collections", completion: completion)?.resume()
    }
}
