//
//  OnboardingPresenterTests.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 23.07.2023.
//

import XCTest
@testable import ECommerce

final class OnboardingPresenterTests: XCTestCase {
    
    var mockView: MockOnboardingViewController!
    var mockInteractor: MockOnboardingInteractor!
    var mockRouter: MockOnboardingRouter!
    var presenter: OnboardingPresenter!
    
    override func setUp() {
        mockView = .init()
        mockInteractor = .init()
        mockRouter = .init()
        presenter = .init(view: mockView, interactor: mockInteractor,  router: mockRouter)
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
    }
    
    func test_viewDidLoad_invokesRequiredMethods() {
        XCTAssertFalse(mockView.invokedSetupConstraint)
        XCTAssertEqual(mockView.invokedSetupConstraintCount, 0)
        XCTAssertFalse(mockInteractor.invokedCreateOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedCreateOnboardingItemsCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.invokedSetupConstraint)
        XCTAssertEqual(mockView.invokedSetupConstraintCount, 1)
        XCTAssertTrue(mockInteractor.invokedCreateOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedCreateOnboardingItemsCount, 1)
    }
    
    func test_numberOfItemsInSection_NumberOfItems_InteractorShowOnboardingItemsCount() {
        var count = 0
        
        XCTAssertFalse(mockInteractor.invokedShowOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedShowOnboardingItemsCount, 0)
        
        count = presenter.numberOfItemsInSection()
        
        XCTAssertTrue(mockInteractor.invokedShowOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedShowOnboardingItemsCount, 1)
        XCTAssertEqual(count, mockInteractor.showOnboardingItems()?.count)
    }
    
    func test_cellForItemAtIndexPath_ReturnsArrayIndexItem() {
        var item: OnboardCellViewModel?
        
        XCTAssertFalse(mockInteractor.invokedShowOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedShowOnboardingItemsCount, 0)
        
        item = presenter.cellForItemAtIndexPath(indexPath: .init(item: 0, section: 0))
        
        XCTAssertTrue(mockInteractor.invokedShowOnboardingItems)
        XCTAssertEqual(mockInteractor.invokedShowOnboardingItemsCount, 1)
        XCTAssertEqual(item?.title, mockInteractor.showOnboardingItems()?[0].title)
    }
    
    func test_cellNextStartButtonTapped_TitleNext_ScrollToNext() {
        XCTAssertFalse(mockView.invokedScrollToNextItem)
        XCTAssertEqual(mockView.invokedScrollToNextItemCount, 0)
        
        presenter.cellNextStartButtonTapped(title: "Next")
        
        XCTAssertTrue(mockView.invokedScrollToNextItem)
        XCTAssertEqual(mockView.invokedScrollToNextItemCount, 1)
    }
    
    func test_cellNextStartButtonTapped_TitleNotEqualNext_ScrollToNext() {
        XCTAssertFalse(mockRouter.invokedToLogin)
        XCTAssertEqual(mockRouter.invokedToLoginCount, 0)
        
        presenter.cellNextStartButtonTapped(title: "")
        
        XCTAssertTrue(mockRouter.invokedToLogin)
        XCTAssertEqual(mockRouter.invokedToLoginCount, 1)
    }
}
