
import Alamofire
import Foundation

public protocol ProjectsRepository {
    
    func listProjects(viewFilter: ProjectFilterViewType,
                      sortOrder: ProjectSortOrderType,
                      sortAscending: Bool,
                      onCompletion: @escaping (Result<[Project], Error>) -> Void)
}

public class StandardProjectsRepository: Repository, ProjectsRepository {
    
    public init(baseURL: String, sessionManager: Session) {
        super.init(baseURL: baseURL, path: "/projects", sessionManager: sessionManager)
    }
    
    public func listProjects(viewFilter: ProjectFilterViewType = .active,
                      sortOrder: ProjectSortOrderType = .name,
                      sortAscending: Bool,
                      onCompletion: @escaping (Result<[Project], Error>) -> Void) {
        
        var sort = ""
        if !sortAscending {
            sort.append("-")
        }
        sort.append(sortOrder.rawValue)
        
        let parameters = ["view" : viewFilter.rawValue,
                          "sort" : sort]
        
        AF.request(apiURL, method: .get, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success:
                if let projectsData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let projectsResponse = try decoder.decode(ProjectsResponse.self, from: projectsData)
                        onCompletion(.success(projectsResponse.projects))
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
    
    private struct ProjectsResponse : Decodable {
        let projects: [Project]
        enum CodingKeys: String, CodingKey {
            case projects = "projects"
        }
    }
    
    private struct ProjectResponse: Decodable {
        let project: Project
        enum CodingKeys: String, CodingKey {
            case project = "project"
        }
    }
}

public enum ProjectFilterViewType: String {
    case active = "active"
    case completed = "completed"
    case cancelled = "cancelled"
    case hidden = "hidden"
}

public enum ProjectSortOrderType: String {
    case name = "name"
    case contactName = "contact_name"
    case contactDisplayName = "contact_display_name"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
}
