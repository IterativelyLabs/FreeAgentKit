
import Foundation

public struct Project: Decodable {
    
    let id: Int?
    let url: String
    let name: String
    let contact: String
    let contactName: String
    let budget: Double
    let budgetUnits: String
    let isIR35: Bool
    let status: String
    let normalBillingRate: Double
    let hoursPerDay: Double
    let usesProjectInvoiceSequence: Bool
    let currency: String
    let billingPeriod: String
    let includeUnbilledTimeInProfitability: Bool
    let createdAt: String
    let updatedAt: String

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
        case includeUnbilledTimeInProfitability = "include_unbilled_time_in_profitability"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
