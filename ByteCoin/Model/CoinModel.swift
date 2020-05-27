import UIKit

struct CoinModel {

let baseName: String
let quoteName: String
let rateValue: Double

var rateString: String {
    
    return String(format: "%.2f", rateValue)
}

}
