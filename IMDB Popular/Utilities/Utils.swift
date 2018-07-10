import Alamofire

var isReachable: Bool {
    return (NetworkReachabilityManager()?.isReachable) ?? false
}
