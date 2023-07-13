//
//  LoginPresenterTests.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 11.07.2023.
//

import Foundation
import XCTest
@testable import ECommerce

final class LoginPresenterTests: XCTestCase {
    
    var mockLoginInteractor: MockLoginInteractor!
    var mockLoginRouter: MockLoginRouter!
    var mockLoginView: MockLoginViewController!
    var presenter: LoginPresenter!
    
    override func setUp() {
        mockLoginRouter = .init()
        mockLoginInteractor = .init()
        mockLoginView = .init()
        presenter = .init(view: mockLoginView, interactor: mockLoginInteractor, router: mockLoginRouter)
    }
    
    override func tearDown() {
        mockLoginRouter = nil
        mockLoginInteractor = nil
        mockLoginView = nil
        presenter = nil
    }
    
    func test_loginButtonTapped_WithSuccessCase_InvokesInteractorLoginMethodAndRouterToHome() {
        XCTAssertFalse(mockLoginInteractor.invokedLogin)
        XCTAssertEqual(mockLoginInteractor.invokedLoginCount, 0)
        XCTAssertFalse(mockLoginRouter.invokedToHome)
        XCTAssertEqual(mockLoginRouter.invokedToHomeCount, 0)
        XCTAssertTrue(mockLoginInteractor.invokedLoginParamsList.isEmpty)
     
        presenter.loginButtonTapped(email: "test@mail", password: "123456")
        presenter.loginSucceed()
        
        XCTAssertTrue(mockLoginInteractor.invokedLogin)
        XCTAssertEqual(mockLoginInteractor.invokedLoginCount, 1)
        XCTAssertTrue(mockLoginRouter.invokedToHome)
        XCTAssertEqual(mockLoginRouter.invokedToHomeCount, 1)
        XCTAssertEqual(mockLoginInteractor.invokedLoginParamsList.map(\.email), ["test@mail"])
        XCTAssertEqual(mockLoginInteractor.invokedLoginParamsList.map(\.password), ["123456"])
    }
    
    func test_loginButtonTapped_WithFailCase_InvokesPresentAlert() {
        XCTAssertFalse(mockLoginInteractor.invokedLogin)
        XCTAssertEqual(mockLoginInteractor.invokedLoginCount, 0)
        XCTAssertFalse(mockLoginView.invokedPresentAlert)
        XCTAssertEqual(mockLoginView.invokedPresentAlertCount, 0)
        XCTAssertTrue(mockLoginView.invokedPresentAlertParamsList.isEmpty)

     
        presenter.loginButtonTapped(email: "", password: "")
        presenter.loginFailed(error: .loginError)
        
        XCTAssertFalse(mockLoginInteractor.invokedLogin)
        XCTAssertEqual(mockLoginInteractor.invokedLoginCount, 0)
        XCTAssertTrue(mockLoginView.invokedPresentAlert)
        XCTAssertEqual(mockLoginView.invokedPresentAlertCount, 2)
        XCTAssertEqual(mockLoginView.invokedPresentAlertParamsList.map(\.message), [GeneralError.emailPasswordEmpty.localizedDescription,
                                                                                    FirebaseError.loginError.localizedDescription])
    }
    
    
    func test_signUpButtonTapped_InvokesRouterToSignUp() {
        XCTAssertFalse(mockLoginRouter.invokedToSignUp)
        XCTAssertEqual(mockLoginRouter.invokedToSignUpCount, 0)
        
        presenter.signUpButtonTapped()
        
        XCTAssertTrue(mockLoginRouter.invokedToSignUp)
        XCTAssertEqual(mockLoginRouter.invokedToSignUpCount, 1)
    }
    
    func test_forgotPasswordTapped_WithEmail_InvokesInteractorForgotPasswordMethod() {
        XCTAssertFalse(mockLoginInteractor.invokedForgotPassword)
        XCTAssertEqual(mockLoginInteractor.invokedForgotPasswordCount, 0)
        XCTAssertTrue(mockLoginInteractor.invokedForgotPasswordParamsList.isEmpty)
        
        presenter.forgotPasswordTapped(email: "test@com")
        
        XCTAssertTrue(mockLoginInteractor.invokedForgotPassword)
        XCTAssertEqual(mockLoginInteractor.invokedForgotPasswordCount, 1)
        XCTAssertEqual(mockLoginInteractor.invokedForgotPasswordParamsList.map(\.email), ["test@com"])
    }
    
    func test_googleSignInTapped_InvokesInteractorGoogleSignInMethod() {
        XCTAssertFalse(mockLoginInteractor.invokedGoogleSignIn)
        XCTAssertEqual(mockLoginInteractor.invokedGoogleSignInCount, 0)
        
        presenter.googleSignInTapped()
        
        XCTAssertTrue(mockLoginInteractor.invokedGoogleSignIn)
        XCTAssertEqual(mockLoginInteractor.invokedGoogleSignInCount, 1)
    }
}
