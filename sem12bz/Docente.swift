import Foundation
import SwiftData

@Model
final class Docente {
    var firstName: String
    var lastName: String
    var apellidoPaterno: String
    var email: String
    var phone: String
    var dateOfBirth: Date
    var positionTitle: String
    var hireDate: Date
    var isActive: Bool

    init(
        firstName: String,
        lastName: String,
        apellidoPaterno: String,
        email: String,
        phone: String,
        dateOfBirth: Date,
        positionTitle: String,
        hireDate: Date,
        isActive: Bool = true
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.apellidoPaterno = apellidoPaterno
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.positionTitle = positionTitle
        self.hireDate = hireDate
        self.isActive = isActive
    }

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
