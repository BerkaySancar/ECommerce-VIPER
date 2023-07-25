//
//  SignUpPresenterTests.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 24.07.2023.
//

import Foundation
@testable import ECommerce
import XCTest

final class SignUpPresenterTests: XCTestCase {
    
    var mockSignUpVC: MockSignUpViewController!
    var mockSignUpRouter: MockSignUpRouter!
    var mockSignUpInteractor: MockSignUpInteractor!
    var presenter: SignUpPresenter!
    
    override func setUp() {
        mockSignUpVC = .init()
        mockSignUpRouter = .init()
        mockSignUpInteractor = .init()
        presenter = .init(view: mockSignUpVC, router: mockSignUpRouter, interactor: mockSignUpInteractor)
    }
    
    override func tearDown() {
        mockSignUpVC = nil
        mockSignUpRouter = nil
        mockSignUpInteractor = nil
        presenter = nil
    }
    
    func test_toLoginTapped_InvokesRouterToLogin() {
        XCTAssertFalse(mockSignUpRouter.invokedToLogin)
        XCTAssertEqual(mockSignUpRouter.invokedToLoginCount, 0)
        
        presenter.toLoginTapped()
        
        XCTAssertTrue(mockSignUpRouter.invokedToLogin)
        XCTAssertEqual(mockSignUpRouter.invokedToLoginCount, 1)
    }
    
    func test_signUpTapped_WithEmptyEmailPassword_PresentAlert() {
        XCTAssertFalse(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 0)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.message), [])
        
        presenter.signUpTapped(email: nil, password: nil)
        
        XCTAssertTrue(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 1)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.message), [GeneralError.emailPasswordEmpty.localizedDescription])
    }
    
    func test_signUpTapped_WithEmailPassword_InvokesInteractorSignUpMethod() {
        XCTAssertFalse(mockSignUpInteractor.invokedSignUpTapped)
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedCount, 0)
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedParams.map(\.email), [])
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedParams.map(\.password), [])

        presenter.signUpTapped(email: "email", password: "password")
        
        XCTAssertTrue(mockSignUpInteractor.invokedSignUpTapped)
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedCount, 1)
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedParams.map(\.email), ["email"])
        XCTAssertEqual(mockSignUpInteractor.invokedSignUpTappedParams.map(\.password), ["password"])
    }
    
    func test_signUpSucceed_PresentVerificationAlert_And_RouterToLogin() {
        XCTAssertFalse(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 0)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.title), [])
        XCTAssertFalse(mockSignUpRouter.invokedToLogin)
        XCTAssertEqual(mockSignUpRouter.invokedToLoginCount, 0)
        
        presenter.signUpSucceed()
        
        XCTAssertTrue(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 1)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.title), ["Verification email sent"])
        XCTAssertTrue(mockSignUpRouter.invokedToLogin)
        XCTAssertEqual(mockSignUpRouter.invokedToLoginCount, 1)
    }
    
    func test_signUpFailed_PresentErrorAlert() {
        XCTAssertFalse(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 0)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.message), [])
        
        presenter.signUpFailed(error: .signUpError)
        
        XCTAssertTrue(mockSignUpVC.invokedPresentAlert)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertCount, 1)
        XCTAssertEqual(mockSignUpVC.invokedPresentAlertParams.map(\.message), [FirebaseError.signUpError.localizedDescription])
    }
}

