
import Alamofire
import Foundation

public protocol ContactsRepository {
    
    func listContacts(viewFilter: ContactFilterViewType,
                      sortOrder: ContactSortOrderType,
                      sortAscending: Bool,
                      onCompletion: @escaping (Result<[Contact], Error>) -> Void)
    
    func createContact(contact: Contact,
                       onCompletion: @escaping (Result<Contact, Error>) -> Void)
    
    func fetchContact(id: Int,
                      onCompletion: @escaping (Result<Contact, Error>) -> Void)
    
    func deleteContact(id: Int,
                       onCompletion: @escaping (Result<Bool, Error>) -> Void)
}

public final class StandardContactsRepository: Repository, ContactsRepository {
    
    public init(baseURL: String, sessionManager: Session) {
        super.init(baseURL: baseURL, path: "/contacts", sessionManager: sessionManager)
    }
    
    public func listContacts(viewFilter: ContactFilterViewType = .all,
                      sortOrder: ContactSortOrderType = .name,
                      sortAscending: Bool = true,
                      onCompletion: @escaping (Result<[Contact], Error>) -> Void) {
        
        var sort = ""
        if !sortAscending {
            sort.append("-")
        }
        sort.append(sortOrder.rawValue)
        
        let parameters = ["view" : viewFilter.rawValue,
                          "sort" : sort]
        
        sessionManager.request(apiURL, method: .get, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success:
                if let contactsData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let contactResponse = try decoder.decode(ContactsResponse.self, from: contactsData)
                        onCompletion(.success(contactResponse.contacts))
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
    
    public func createContact(contact: Contact,
                       onCompletion: @escaping (Result<Contact, Error>) -> Void) {
        
        if contact.id != nil {
            onCompletion(.failure(idCannotBeSet()))
            return
        }
        
        let parameters = ["contact" : contact]
        
        sessionManager.request(apiURL, method: .post, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success:
                if let contactData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let contactResponse = try decoder.decode(ContactResponse.self, from: contactData)
                        onCompletion(.success(contactResponse.contact))
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
    
    public func fetchContact(id: Int,
                      onCompletion: @escaping (Result<Contact, Error>) -> Void) {
        
        if id <= 0 {
            onCompletion(.failure(idMustBeNonZero()))
            return
        }
        
        sessionManager.request(apiURL, method: .get, parameters: ["id" : id]).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success:
                if let contactData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let contactResponse = try decoder.decode(ContactResponse.self, from: contactData)
                        onCompletion(.success(contactResponse.contact))
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
    
    public func deleteContact(id: Int,
                       onCompletion: @escaping (Result<Bool, Error>) -> Void) {
        
        if id <= 0 {
            onCompletion(.failure(idMustBeNonZero()))
            return
        }
        
        sessionManager.request(apiURL, method: .delete, parameters: ["id" : id]).response { response in
            if response.error?.underlyingError != nil {
                onCompletion(.failure(response.error!.underlyingError!))
            } else {
                onCompletion(.success(response.response?.statusCode == 200))
            }
        }
    }

    private struct ContactsResponse : Decodable {
        let contacts: [Contact]
        enum CodingKeys: String, CodingKey {
            case contacts = "contacts"
        }
    }
    
    private struct ContactResponse: Decodable {
        let contact: Contact
        enum CodingKeys: String, CodingKey {
            case contact = "contact"
        }
    }
}

public enum ContactFilterViewType: String {
    case all = "all"
    case active = "active"
    case clients = "clients"
    case suppliers = "suppliers"
    case active_projects = "active_projects"
    case completed_projects = "completed_projects"
    case open_clients = "open_clients"
    case open_suppliers = "open_suppliers"
    case hidden = "hidden"
}

public enum ContactSortOrderType: String {
    case name = "name"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
}
