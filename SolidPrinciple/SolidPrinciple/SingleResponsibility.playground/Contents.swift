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
    
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
    func saveInvoice() {
        let persistence = InvoicePersistence(invoice: self)
        persistence.saveInvoice()
    }
}

struct InvoicePrinter {
    let invoice: Invoice
    
    func printInvoice() {
        print("-------------------------")
        print("Invoice id: \(invoice.id)")
        print("Total cost $\(invoice.total)")
        print("Discounts: \(invoice.discountPecentage)")
        print("-------------------------")
    }
}

struct InvoicePersistence {
    let invoice: Invoice
    
    func saveInvoice() {
        print("------Save invoice success------")
    }
}

let products: [Product] = [
    .init(price: 99.99),
    .init(price: 9.99),
    .init(price: 24.99)
]

let invoice1 = Invoice(products: products, discountPecentage: 20)
invoice1.printInvoice()
invoice1.saveInvoice()

let invoice2 = Invoice(products: products)
invoice2.printInvoice()
invoice2.saveInvoice()


