
import Alamofire
import Foundation

internal final class FreeAgentRequestInterceptor: Alamofire.RequestInterceptor {

    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest

        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}
