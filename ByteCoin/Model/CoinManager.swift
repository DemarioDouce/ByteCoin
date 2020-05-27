import UIKit

protocol CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error:Error)
    
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C3CEDC80-711F-4168-AB2D-96F778A6D91B"
    
    //Delegate
    var delegate:CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //Get the price of the selected currency
    func getCoinPrice(for currency: String){
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
        
        
    }
    
    //Networking
    func performRequest(with urlString: String)  {
        
        //1. Create a URL
        let url = URL(string: urlString)
        
        //2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        
        //using closer
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            
            if let safeData = data {
                
                if let coin = self.parseJSON(safeData){
                    
                    self.delegate?.didUpdateCoin(self,coin:coin)
                }

            }
        }
        
        //4. Start the task
        task.resume()
    }
    
    //Parse data JSON
    func parseJSON(_ coinData:Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        
        do{
            
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let baseName = decodedData.asset_id_base
            let quoteName = decodedData.asset_id_quote
            let rateValue = decodedData.rate
            
            let coin = CoinModel(baseName: baseName, quoteName: quoteName, rateValue: rateValue)
            
            return coin
            
            
            
        } catch{
            
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
