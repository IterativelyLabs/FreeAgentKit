
import Alamofire
import Foundation

public final class FreeAgentRequestInterceptor: Alamofire.RequestInterceptor {

    // FIXME: Remove this and get it from keychain
    private let accessToken = "1ABPaABv-3w1zw1kS_oV1DZ7PPl2yfFJE9KvLQR6e"
    
    public init() {
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest

        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}
