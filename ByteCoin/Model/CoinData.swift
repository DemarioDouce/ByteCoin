import UIKit

//JSON coin structor
struct CoinData: Codable {
    
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}


