import Alamofire
import Foundation


open class Repository {
    
    let baseURL: String
    let sessionManager: Session
    let apiURL: String
    
    
    init(baseURL: String, path: String, sessionManager: Session) {
        self.baseURL = baseURL
        self.apiURL = "\(baseURL)\(path)"
        self.sessionManager = sessionManager
    }

    // 
    
    func badResponse() -> Error {
        return NSError(domain: "FreeAgent",
                       code: 10,
                       userInfo: [NSLocalizedDescriptionKey : "Bad Response"])

    }
    
    func idCannotBeSet() -> Error {
        return NSError(domain: "FreeAgent",
                       code: 200,
                       userInfo: [NSLocalizedDescriptionKey : "ID cannot be set for creation request"])
    }
    
    func idMustBeNonZero() -> Error {
        return NSError(domain: "FreeAgent",
                       code: 201,
                       userInfo: [NSLocalizedDescriptionKey : "ID must be non zero"])
    }
}

