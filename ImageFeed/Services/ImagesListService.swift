//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/20/24.
//

import Foundation

final class ImageListService {
    
    // MARK: - Public Properties
    static let shared = ImageListService()
    private init() {}
    static let didChangeNotification = Notification.Name(rawValue: "ImageListServiceDidChange")
    
    // MARK: - Private properties
    private (set) var photos: [Photo] = []
    private (set) var photoURL: String?
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private let token = OAuth2TokenStorage().token
    
    // MARK: - Public Methods
    func fetchPhotosNextPage(token: String) {
        assert(Thread.isMainThread)
        guard task == nil else { return }
        let request = makePhotosRequest(token: token)
        let task = URLSession.shared.arrayObjectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) -> Void in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let photoResult):
                    let array = photoResult.map {Photo(from: $0) }
                    self.photos += array
                    //                    print(self.photos)
                    NotificationCenter.default.post(
                        name: ImageListService.didChangeNotification,
                        object: self,
                        userInfo: ["Photos": self.photos])
                case .failure(let error):
                    print("Ошибка: \(error)")
                }
                self.task = nil
            }
        }
        self.task = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makePhotosRequest(token: String) -> URLRequest {
        let pageNumber = photos.count / 10 + 1
        var request = URLRequest.makeHTTPRequest(
            path: "/photos/"
            + "?client_id=\(Constants.accessKey)"
            + "&page=\(pageNumber)",
            httpMethod: "GET")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func makeLikeRequest(photoId: String, isLike: Bool) -> URLRequest {
        let method = isLike ? "POST" : "DELETE"
        var request = URLRequest.makeHTTPRequest(
            path: "/photos/"
            + "\(photoId)"
            + "/like",
            httpMethod: "\(method)")
        if let token = token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else { print("Token not found for makeLikeRequest") }
        return request
    }
}
