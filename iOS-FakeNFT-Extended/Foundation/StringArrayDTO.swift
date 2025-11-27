import Foundation

struct StringArrayDTO: Encodable {
    let strings: [String]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(contentsOf: strings)
    }
}
