//
//  ProfileViewTestss.swift
//  ProfileViewTestss
//
//  Created by Олег Серебрянский on 3/3/24.
//

@testable import ImageFeed

import XCTest

final class ProfileViewTests: XCTestCase {
    
    func testProfileViewPresenterAddObserver() {
        // given
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.configure(presenter: presenter)
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.observer)
    }
    
    func testProfileViewPresenterUpdateProfileImage() {
        // given
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.configure(presenter: presenter)
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.updateProfileImageCalled)
    }
}
