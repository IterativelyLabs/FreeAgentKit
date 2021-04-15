
import Alamofire
import Foundation

internal final class FreeAgentRequestInterceptor: Alamofire.RequestInterceptor {

    // FIXME: Remove this and get it from keychain
    private let accessToken = "1ABPaABv--RzSbmpH4bGOOpzAXgUMIq_nGVQdG8f7"
    
    public func adapt(_ urlRequest: URLRequest, for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest

        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}
