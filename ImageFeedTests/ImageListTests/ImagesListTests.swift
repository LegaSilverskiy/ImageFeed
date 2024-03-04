//
//  ImageListTests.swift
//  ImageFeedTests
//
//  Created by Олег Серебрянский on 3/4/24.
//

@testable import ImageFeed

import XCTest

final class ImagesListTests: XCTestCase {
    
    func testImageListPresenterAddObserver() {
        // given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresenterSpy()
        
        viewController.configure(presenter: presenter)
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.observerIsLoading)
        XCTAssertTrue(presenter.photosAreLoading)
    }

}
