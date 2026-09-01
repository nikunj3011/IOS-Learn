import Foundation

struct Crypto: Identifiable, Decodable {
    var id: String { symbol }

    let rank: Int
    let name: String
    let symbol: String
    let price: String
    let change24h: String
    let volume24h: String
//    let marketCap: String

    enum CodingKeys: String, CodingKey {
        case rank, name, symbol, price
        case change24h = "24hChange"
        case volume24h = "24hVolume"
//        case marketCap
    }
}
