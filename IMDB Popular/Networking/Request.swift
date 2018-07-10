import Alamofire
import Foundation

private let baseAPI = "https://api.themoviedb.org/3/"
private let theMobieDbToken = "9606d0f761d04a5129e2a253001f9d18"

enum Encoding {
    case string
    case json
}

struct RequestInputs {
    var parameters: [String: Any]
    let path: String
    let method: Alamofire.HTTPMethod
    let onSuccess: (Any?) -> Void
    let onFailure: (ErrorType) -> Void
    
    init(params: [String: Any]? = nil,
         path: String,
         method: Alamofire.HTTPMethod = .get,
         onSuccess: @escaping (Any?) -> Void,
         onFailure: @escaping (ErrorType) -> Void) {
        self.parameters = [String: Any]()
        if let validParams = params {
            self.parameters = validParams
        }
        self.parameters.updateValue(theMobieDbToken, forKey: "api_key")
        self.path = path
        self.method = method
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
}

struct Request {
    init(inputs: RequestInputs, encoding: Encoding) {
        if !isReachable {
            inputs.onFailure(.connection)

            return
        }
        guard let url = URL(string: baseAPI) else {
            inputs.onFailure(.undefined)
            
            return
        }
        switch encoding {
        case .string: stringRequest(with: inputs, url: url)
        case .json: jsonRequest(with: inputs, url: url)
        }
    }
    
    private func stringRequest(with inputs: RequestInputs, url: URL) {        
        Alamofire.request(url.appendingPathComponent(inputs.path),
                          method: inputs.method,
                          parameters: inputs.parameters).responseString(completionHandler: { (response) in
                            switch response.result {
                            case .success: inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
    
    private func jsonRequest(with inputs: RequestInputs, url: URL) {
        Alamofire.request(url.appendingPathComponent(inputs.path),
                          method: inputs.method,
                          parameters: inputs.parameters).responseJSON(completionHandler: { response in
                            switch response.result {
                            case .success: inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
}
