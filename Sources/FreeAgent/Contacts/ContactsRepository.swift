
import Alamofire
import Foundation

protocol ContactsRepository {
    
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

class StandardContactsRepository: Repository, ContactsRepository {
    
    private let endpoint: String
    
    override init(baseURL: String) {
        self.endpoint = "\(baseURL)/contacts"
        super.init(baseURL: baseURL)
    }
    
    func listContacts(viewFilter: ContactFilterViewType = .all,
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
        
        AF.request(endpoint, method: .get, parameters: parameters).responseJSON { [weak self] response in
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
    
    func createContact(contact: Contact,
                       onCompletion: @escaping (Result<Contact, Error>) -> Void) {
        
        if contact.id != nil {
            onCompletion(.failure(idCannotBeSet()))
            return
        }
        
        let parameters = ["contact" : contact]
        
        AF.request(endpoint, method: .post, parameters: parameters).responseJSON { [weak self] response in
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
    
    func fetchContact(id: Int,
                      onCompletion: @escaping (Result<Contact, Error>) -> Void) {
        
        if id <= 0 {
            onCompletion(.failure(idMustBeNonZero()))
            return
        }
        
        AF.request(endpoint, method: .get, parameters: ["id" : id]).responseJSON { [weak self] response in
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
    
    func deleteContact(id: Int,
                       onCompletion: @escaping (Result<Bool, Error>) -> Void) {
        
        if id <= 0 {
            onCompletion(.failure(idMustBeNonZero()))
            return
        }
        
        AF.request(endpoint, method: .delete, parameters: ["id" : id]).response { response in
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

enum ContactFilterViewType: String {
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

enum ContactSortOrderType: String {
    case name = "name"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
}
