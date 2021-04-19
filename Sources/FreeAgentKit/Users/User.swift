
import Foundation

public struct User: Codable {
    public let url: String
    public let email: String
    public let firstName: String
    public let lastName: String
    public let niNumber: String?
    public let uniqueTaxReference: String?
    public let role: UserRole
    public let openingMileage: Double
    public let sendInvitation: Bool?
    public let permissionLevel: PermissionLevel?
    public let createdAt: String
    public let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case niNumber = "ni_number"
        case uniqueTaxReference = "unique_tax_reference"
        case role = "role"
        case openingMileage = "opening_mileage"
        case sendInvitation = "send_invitation"
        case permissionLevel = "permission_level"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

public enum PermissionLevel: Int, Codable {
    case noAccess = 0
    case time = 1
    case myMoney = 2
    case contactsAndProjects = 3
    case invoicesEstimatesAndFiles = 4
    case bills = 5
    case banking = 6
    case taxAccountingAndUsers = 7
    case full = 8
}

public enum UserRole: String, Codable {
    case Owner = "Owner"
    case Director = "Director"
    case Partner = "Partner"
    case CompanySecretary = "Company Secretary"
    case Employee = "Employee"
    case Shareholder = "Shareholder"
    case Accountant = "Accountant"
}
