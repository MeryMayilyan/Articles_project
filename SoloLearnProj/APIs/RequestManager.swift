
import UIKit
import Alamofire

class RequestManager {
    
    static let shared = RequestManager()
    private init() {}

    let sessionManager = Alamofire.SessionManager.default
    
    func getRequest (_ strURL: String, success:@escaping (ArticleResponseModel) -> Void, failure:@escaping (String) -> Void) {
        let url = strURL
        sessionManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            if response.result.isSuccess {
                if response.result.value != nil {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        
                        let data = reqJSONStr?.data(using: .utf8)
                        let jsonDecoder = JSONDecoder()
                        let responseData = try
                            jsonDecoder.decode(ArticleResponseModel.self, from: data!)
                        
                        success(responseData)
                    } catch {
                        print(error)
                    }
                }
            }
            else {
                if response.result.error != nil {
                    if response.response?.statusCode == 401 {
                        failure("401")
                    } else {
                        failure("1000")
                    }
                } else if let x  = (response.response?.statusCode) {
                    failure(String(x))
                }
            }
        }
    }
    
}

