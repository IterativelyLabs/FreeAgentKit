import Foundation

public struct Contact: Codable {
    public let id: Int?
    public let url: String
    public let firstName: String?
    public let lastName: String?
    public let organisationName: String?
    public let email: String
    public let billingEmail: String?
    public let phoneNumber: String?
    public let mobile: String?
    public let address1: String?
    public let address2: String?
    public let address3: String?
    public let town: String?
    public let region: String?
    public let postcode: String?
    public let country: String?
    public let contactNameOnInvoices: Bool?
    public let defaultPaymentTermsInDays: Int?
    public let locale: String?
    public let accountBalance: String?
    public let usesContactInvoiceSequence: Bool?
    public let chargeSalesTax: ChargeSalesTax
    public let salesTaxRegistrationNumber: String?
    public let activeProjectsCount: Int?
    public let directDebitMandateState: DirectDebitMandateState?
    public let status: ContactStatus
    public let createdAt: String
    public let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case firstName = "first_name"
        case lastName = "last_name"
        case organisationName = "organisation_name"
        case email = "email"
        case billingEmail = "billing_email"
        case phoneNumber = "phone_number"
        case mobile = "mobile"
        case address1 = "address1"
        case address2 = "address2"
        case address3 = "address3"
        case town = "town"
        case region = "region"
        case postcode = "postcode"
        case country = "country"
        case contactNameOnInvoices = "contact_name_on_invoices"
        case defaultPaymentTermsInDays = "default_payment_terms_in_days"
        case locale = "locale"
        case accountBalance = "account_balance"
        case usesContactInvoiceSequence = "uses_contact_invoice_sequence"
        case chargeSalesTax = "charge_sales_tax"
        case salesTaxRegistrationNumber = "sales_tax_registration_number"
        case activeProjectsCount = "active_projects_count"
        case directDebitMandateState = "direct_debit_mandate_state"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

public enum DirectDebitMandateState: String, Codable {
    case active = "active"
    case cancelled = "cancelled"
    case expired = "expired"
    case failed = "failed"
    case inactive = "inactive"
    case pending =  "pending"
    case setup = "setup"
}

public enum ContactStatus: String, Codable {
    case active = "Active"
    case hidden = "Hidden"
}

public enum ChargeSalesTax: String, Codable {
    case auto = "Auto"
    case always = "Always"
    case never = "Never"
}
