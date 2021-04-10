import Foundation

public struct Contact: Codable {
    let id: Int?
    let url: String
    let firstName: String?
    let lastName: String?
    let organisationName: String?
    let email: String
    let billingEmail: String?
    let phoneNumber: String?
    let mobile: String?
    let address1: String?
    let address2: String?
    let address3: String?
    let town: String?
    let region: String?
    let postcode: String?
    let country: String?
    let contactNameOnInvoices: Bool?
    let defaultPaymentTermsInDays: Int?
    let locale: String?
    let accountBalance: String?
    let usesContactInvoiceSequence: Bool?
    let chargeSalesTax: String?
    let salesTaxRegistrationNumber: String?
    let activeProjectsCount: Int?
    let directDebitMandateState: String?
    let status: String
    let createdAt: String
    let updatedAt: String    
    
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
