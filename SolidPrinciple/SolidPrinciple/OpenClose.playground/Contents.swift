import UIKit

struct Product {
    let price: Double
}

struct Invoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPecentage: Double = 0
    
    var total: Double {
        let total = products.map { $0.price }.reduce(0, +)
        let discountAmount = total * (discountPecentage/100)
        return total - discountAmount
    }
}


protocol InvoicePersistable {
    func save(invoce: Invoice)
}

struct InvoicePersistenceOCP {
    let persistence: InvoicePersistable
    
    init(persistence: InvoicePersistable) {
        self.persistence = persistence
    }
}

struct CoreDataPersistence: InvoicePersistable {
    func save(invoce: Invoice) {
        print("----------save core data-------------")
    }
}

struct DatabasePersistence: InvoicePersistable {
    func save(invoce: Invoice) {
        print("----------save data base-------------")
    }
}

var persistenceOCP = InvoicePersistenceOCP(persistence: CoreDataPersistence())
persistenceOCP.persistence.save(invoce: Invoice(products: []))

persistenceOCP = InvoicePersistenceOCP(persistence: DatabasePersistence())
persistenceOCP.persistence.save(invoce: Invoice(products: []))
