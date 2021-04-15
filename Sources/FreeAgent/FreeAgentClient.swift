
import Alamofire
import Foundation

public class FreeAgentClient {
    
    private let baseURL: String
    private let sessionManager: Session
    
    private lazy var contactsRepository: ContactsRepository = {
        return StandardContactsRepository(baseURL: baseURL, sessionManager: sessionManager)
    }()
    
    private lazy var projectsRepository: ProjectsRepository = {
        return StandardProjectsRepository(baseURL: baseURL, sessionManager: sessionManager)
    }()
    
    
    public init(baseURL: String, accessToken: String) {
        self.baseURL = baseURL
        self.sessionManager = Alamofire.Session(interceptor: FreeAgentRequestInterceptor(accessToken: accessToken))
    }
    
    
    public func listContacts(viewFilter: ContactFilterViewType = .all,
                             sortOrder: ContactSortOrderType = .name, sortAscending:Bool = true,
                             onCompletion: @escaping (Result<[Contact], Error>) -> Void) {
        
        contactsRepository.listContacts(viewFilter: viewFilter, sortOrder: sortOrder,
                                        sortAscending: sortAscending, onCompletion: onCompletion)
    }
    
    public func listProjects(viewFilter: ProjectFilterViewType = .active,
                             sortOrder: ProjectSortOrderType = .name,
                             sortAscending: Bool = true,
                             onCompletion: @escaping (Result<[Project], Error>) -> Void) {
        
        projectsRepository.listProjects(viewFilter: viewFilter, sortOrder: sortOrder,
                                sortAscending: sortAscending, onCompletion: onCompletion)
    }
}
