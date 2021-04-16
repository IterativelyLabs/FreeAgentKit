
import Foundation

public struct Project: Decodable {
    
    public let id: Int?
    public let url: String
    public let name: String
    public let contact: String
    public let contactName: String
    public let budget: Double
    public let budgetUnits: BudgetUnit
    public let isIR35: Bool
    public let status: ProjectStatus
    public let normalBillingRate: Double
    public let hoursPerDay: Double
    public let usesProjectInvoiceSequence: Bool
    public let currency: String
    public let billingPeriod: BillingPeriod
    public let startsOn: Date?
    public let endsOn: Date?
    public let includeUnbilledTimeInProfitability: Bool
    public let createdAt: String
    public let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case name = "name"
        case contact = "contact"
        case contactName = "contact_name"
        case budget = "budget"
        case budgetUnits = "budget_units"
        case isIR35 = "is_ir35"
        case status = "status"
        case normalBillingRate = "normal_billing_rate"
        case hoursPerDay = "hours_per_day"
        case usesProjectInvoiceSequence = "uses_project_invoice_sequence"
        case currency = "currency"
        case billingPeriod = "billing_period"
        case startsOn = "starts_on"
        case endsOn = "ends_on"
        case includeUnbilledTimeInProfitability = "include_unbilled_time_in_profitability"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

public enum ProjectStatus: String, Codable {
    case active = "Active"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case hidden = "Hidden"
}

public enum BudgetUnit: String, Codable {
    case hours = "Hours"
    case days = "Days"
    case monetary = "Monetary"
}

public enum BillingPeriod: String, Codable {
    case hour = "Hour"
    case day = "Day"
}
