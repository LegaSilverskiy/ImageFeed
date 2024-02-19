//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/13/24.
//

import Foundation

final class ProfileImageService {
    
    // MARK: - Public properties
    static let shared = ProfileImageService()
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    // MARK: - Private properties
    private (set) var profileImageURL: String?
    private var task: URLSessionTask?
    private let token = OAuth2TokenStorage().token
    private let urlSession = URLSession.shared
     
    // MARK: - Public methods
    func fetchProfileImageURL(username: String, token: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        guard task == nil else { fatalError("error") }
        let request = makeProfileImageRequest(userName: username, token: token)
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) -> Void in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let profileImageData):
                    self.profileImageURL = profileImageData.profileImage.small
                    completion(.success(profileImageData.profileImage.small))
                    print(profileImageData)
                    NotificationCenter.default
                        .post(
                            name: ProfileImageService.didChangeNotification,
                            object: self,
                            userInfo: ["URL": self.profileImageURL as Any])
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
                self.task = nil
            }
        }
        self.task = task
        task.resume()
    }
    
    // MARK: - Private methods
    private func makeProfileImageRequest(userName: String, token: String) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(path: "/users/\(userName)", httpMethod: "GET")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
