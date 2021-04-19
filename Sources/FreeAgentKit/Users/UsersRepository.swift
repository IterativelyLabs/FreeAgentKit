
import Alamofire
import Foundation

protocol UsersRepository {
    
    func currentActiveUser(onCompletion: @escaping (Result<User, Error>) -> Void)
    
}

class StandardUsersRepository: Repository, UsersRepository {
    
    public init(baseURL: String, sessionManager: Session) {
        super.init(baseURL: baseURL, path: "/users", sessionManager: sessionManager)
    }
    
    public func currentActiveUser(onCompletion: @escaping (Result<User, Error>) -> Void) {
        
        sessionManager.request("\(apiURL)/me", method: .get).responseJSON { [weak self] response in
            guard let self = self else { return }            
            switch response.result {
            case .success:
                if let userData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let userResponse = try decoder.decode(UserResponse.self, from: userData)
                        onCompletion(.success(userResponse.user))
                    } catch {
                        onCompletion(.failure(self.badResponse()))
                    }
                } else {
                    onCompletion(.failure(self.badResponse()))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    private struct UsersResponse : Decodable {
        let users: [User]
        enum CodingKeys: String, CodingKey {
            case users = "users"
        }
    }
    
    private struct UserResponse: Decodable {
        let user: User
        enum CodingKeys: String, CodingKey {
            case user = "user"
        }
    }
}
