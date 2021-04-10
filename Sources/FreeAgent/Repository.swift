import Foundation


class Repository {
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
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

