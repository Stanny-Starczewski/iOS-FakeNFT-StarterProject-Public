import Foundation

extension String {
    var encodeUrl: String {
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return ""
        }
        return encodedString
    }
}
