import Foundation
<<<<<<<< HEAD:FakeNFT/Presentation/Stats/View/StatUserPage.swift
import Kingfisher
========
>>>>>>>> stat:FakeNFT/Screens/Stats/StatUserPage/StatUserPageModel.swift

final class StatUserPageModel {
    private let defaultNetworkClient = DefaultNetworkClient()

    func getUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        let request = Request(endpoint: URL(string: Config.baseUrl + "/users" + "/\(userId)"), httpMethod: .get)
        defaultNetworkClient.send(request: request, type: User.self, onResponse: completion)
    }
}

