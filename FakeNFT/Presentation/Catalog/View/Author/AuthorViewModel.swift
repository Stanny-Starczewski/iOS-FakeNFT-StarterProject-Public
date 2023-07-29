import Foundation

final class AuthorViewModel {
    let authorPageURL: String
    @Observable private(set) var loadingInProgress: Bool = false
    
    init(authorPageURL: String) {
        self.authorPageURL = authorPageURL
    }
    
    func changeLoadingStatus(loadingInProgress: Bool) {
        self.loadingInProgress = loadingInProgress
    }
}
