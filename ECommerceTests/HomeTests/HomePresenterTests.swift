//
//  HomePresenterTests.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 25.07.2023.
//

import Foundation
@testable import ECommerce
import XCTest

final class HomePresenterTests: XCTestCase {
    
    var mockHomeVC: MockHomeViewController!
    var mockHomeRouter: MockHomeRouter!
    var mockHomeInteractor: MockHomeInteractor!
    var presenter: HomePresenter!
    
    override func setUp() {
        mockHomeVC = .init()
        mockHomeRouter = .init()
        mockHomeInteractor = .init()
        presenter = .init(view: mockHomeVC, interactor: mockHomeInteractor, router: mockHomeRouter)
    }
    
    override func tearDown() {
        mockHomeVC = nil
        mockHomeInteractor = nil
        mockHomeRouter = nil
        presenter = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(mockHomeVC.invokedSetViewBgColor)
        XCTAssertEqual(mockHomeVC.invokedSetViewBgColorCout, 0)
        XCTAssertNil(mockHomeVC.invokedSetViewBgColorParameter)
        XCTAssertFalse(mockHomeVC.invokedPrepareSearchBar)
        XCTAssertEqual(mockHomeVC.invokedPrepareSearchBarCount, 0)
        XCTAssertFalse(mockHomeVC.invokedPrepareNavBarView)
        XCTAssertEqual(mockHomeVC.invokedPrepareNavBarViewCount, 0)
        XCTAssertFalse(mockHomeVC.invokedPrepareHomeCollectionView)
        XCTAssertEqual(mockHomeVC.invokedPrepareHomeCollectionViewCount, 0)
        XCTAssertFalse(mockHomeVC.invokedPrepareAIV)
        XCTAssertEqual(mockHomeVC.invokedPrepareAIVCount, 0)
        XCTAssertFalse(mockHomeInteractor.invokedGetData)
        XCTAssertEqual(mockHomeInteractor.invokedGetDataCount, 0)
        XCTAssertFalse(mockHomeInteractor.invokedGetUserInfos)
        XCTAssertEqual(mockHomeInteractor.invokedGetUserInfosCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockHomeVC.invokedSetViewBgColor)
        XCTAssertEqual(mockHomeVC.invokedSetViewBgColorCout, 1)
        XCTAssertEqual(mockHomeVC.invokedSetViewBgColorParameter, .systemBackground)
        XCTAssertTrue(mockHomeVC.invokedPrepareSearchBar)
        XCTAssertEqual(mockHomeVC.invokedPrepareSearchBarCount, 1)
        XCTAssertTrue(mockHomeVC.invokedPrepareNavBarView)
        XCTAssertEqual(mockHomeVC.invokedPrepareNavBarViewCount, 1)
        XCTAssertTrue(mockHomeVC.invokedPrepareHomeCollectionView)
        XCTAssertEqual(mockHomeVC.invokedPrepareHomeCollectionViewCount, 1)
        XCTAssertTrue(mockHomeVC.invokedPrepareAIV)
        XCTAssertEqual(mockHomeVC.invokedPrepareAIVCount, 1)
        XCTAssertTrue(mockHomeInteractor.invokedGetData)
        XCTAssertEqual(mockHomeInteractor.invokedGetDataCount, 1)
        XCTAssertTrue(mockHomeInteractor.invokedGetUserInfos)
        XCTAssertEqual(mockHomeInteractor.invokedGetUserInfosCount, 1)
    }
    
    func test_viewWillAppear_InvokesRequiredMethods() {
        XCTAssertFalse(mockHomeVC.invokedSetNavTabVisibility)
        XCTAssertEqual(mockHomeVC.invokedSetNavTabVisibilityCount, 0)
        XCTAssertFalse(mockHomeInteractor.invokedGetFavorites)
        XCTAssertEqual(mockHomeInteractor.invokedGetFavoritesCount, 0)

        presenter.viewWillAppear()
        
        XCTAssertTrue(mockHomeVC.invokedSetNavTabVisibility)
        XCTAssertEqual(mockHomeVC.invokedSetNavTabVisibilityCount, 1)
        XCTAssertTrue(mockHomeInteractor.invokedGetFavorites)
        XCTAssertEqual(mockHomeInteractor.invokedGetFavoritesCount, 1)
    }
    
    func test_numberOfSection_Return_2() {
        var numOfSection: Int
        
        numOfSection = presenter.numberOfSection()
        
        XCTAssertEqual(numOfSection, 2)
    }
    
    func test_numberOfItemsInSection_FirstSection_ReturnsInteractorShowCategoriesCount() {
        var numOfItems: Int
        
        numOfItems = presenter.numberOfItemsInSection(section: 0)
        
        XCTAssertEqual(numOfItems, mockHomeInteractor.showCategories().count)
    }
    
    func test_numberOfItemsInSection_SecondSection_ReturnsInteractorShowProductsCount() {
        var numOfItems: Int
        
        numOfItems = presenter.numberOfItemsInSection(section: 1)
        
        XCTAssertEqual(numOfItems, mockHomeInteractor.showProducts().count)
    }
    
    func test_sizeForItemAt_SecondSection_ReturnsCGSize() {
        var size: CGSize?
        
        size = presenter.sizeForItemAt(indexPath: .init(item: 0, section: 1))
        
        XCTAssertEqual(size, CGSize(width: UIScreenBounds.width / 2.3, height: 300))
    }
    
    func test_didSelectItemAt_FirstItemSecondSection_InvokesRouterToDetail() {
        XCTAssertFalse(mockHomeRouter.invokedToDetail)
        XCTAssertEqual(mockHomeRouter.invokedToDetailCount, 0)
        XCTAssertNil(mockHomeRouter.invokedToDetailParameter)
        
        presenter.didSelectItemAt(indexPath: .init(item: 0, section: 1))
        
        XCTAssertTrue(mockHomeRouter.invokedToDetail)
        XCTAssertEqual(mockHomeRouter.invokedToDetailCount, 1)
        XCTAssertEqual(mockHomeRouter.invokedToDetailParameter, mockHomeInteractor.showProducts()[0].id)
    }
    
    func test_showProducts_ReturnsInteractorShowProducts() {
        var products: [ProductModel]?
        
        products = presenter.showProducts()
        
        XCTAssertEqual(products, mockHomeInteractor.showProducts())
    }
    
    func test_showCategories_ReturnsInteractorShowCategories() {
        var categories: Categories?
        
        categories = presenter.showCategories()
        
        XCTAssertEqual(categories, mockHomeInteractor.showCategories().map { $0.capitalized })
    }
    
    func test_searchTextDidChange_WithSearchText_InvokesInteractorSearchTextDidChangeMethod() {
        XCTAssertFalse(mockHomeInteractor.invokedSearchTextDidChange)
        XCTAssertEqual(mockHomeInteractor.invokedSearchTextDidChangeCount, 0)
        XCTAssertNil(mockHomeInteractor.invokedSearchTextDidChangeParameter)
        
        presenter.searchTextDidChange(text: "search")
        
        XCTAssertTrue(mockHomeInteractor.invokedSearchTextDidChange)
        XCTAssertEqual(mockHomeInteractor.invokedSearchTextDidChangeCount, 1)
        XCTAssertEqual(mockHomeInteractor.invokedSearchTextDidChangeParameter, "search")
    }
    
    func test_categorySelected_WithCategory_InvokesInteractorGetCategoryProducts() {
        XCTAssertFalse(mockHomeInteractor.invokedGetCatProducts)
        XCTAssertEqual(mockHomeInteractor.invokedGetCatProductsCount, 0)
        XCTAssertNil(mockHomeInteractor.invokedGetCatProductsParameter)
        
        presenter.categorySelected(category: "category")
        
        XCTAssertTrue(mockHomeInteractor.invokedGetCatProducts)
        XCTAssertEqual(mockHomeInteractor.invokedGetCatProductsCount, 1)
        XCTAssertEqual(mockHomeInteractor.invokedGetCatProductsParameter, "category")
    }
    
    func test_isFav_WIthFirstItemSecondSection_ReturnsInteractorIsFav() {
        var bool: Bool?
        XCTAssertFalse(mockHomeInteractor.invokedIsFav)
        XCTAssertEqual(mockHomeInteractor.invokedIsFavCount, 0)
        XCTAssertNil(mockHomeInteractor.invokedIsFavParameter)
        
        bool = presenter.isFav(indexPath: .init(item: 0, section: 1))
        
        XCTAssertEqual(bool, false)
        XCTAssertTrue(mockHomeInteractor.invokedIsFav)
        XCTAssertEqual(mockHomeInteractor.invokedIsFavCount, 1)
        XCTAssertEqual(mockHomeInteractor.invokedIsFavParameter, presenter.showProducts()?[0])
    }
    
    func test_favTapped_WithProductModel_InvokesInteractorFavAction() {
        XCTAssertFalse(mockHomeInteractor.invokedFavAction)
        XCTAssertEqual(mockHomeInteractor.invokedFavActionCount, 0)
        XCTAssertNil(mockHomeInteractor.invokedFavActionParameter)
        
        
        let mockModel: ProductModel = .init(id: 1,
                                            title: "title",
                                            price: 1,
                                            description: "description",
                                            category: "category",
                                            image: "image",
                                            rating: .init(rate: 1, count: 1)
                                           )
        presenter.favTapped(model: mockModel)
        
        XCTAssertTrue(mockHomeInteractor.invokedFavAction)
        XCTAssertEqual(mockHomeInteractor.invokedFavActionCount, 1)
        XCTAssertEqual(mockHomeInteractor.invokedFavActionParameter, mockModel)
    }
    
    func test_startLoading_InvokesViewStartLoading() {
        XCTAssertFalse(mockHomeVC.invokedStartLoading)
        XCTAssertEqual(mockHomeVC.invokedStartLoadingCount, 0)
        
        presenter.startLoading()
        
        XCTAssertTrue(mockHomeVC.invokedStartLoading)
        XCTAssertEqual(mockHomeVC.invokedStartLoadingCount, 1)
    }
    
    func test_endLoading_InvokesViewEndLoading() {
        XCTAssertFalse(mockHomeVC.invokedEndLoading)
        XCTAssertEqual(mockHomeVC.invokedEndLoadingCount, 0)
        
        presenter.endLoading()
        
        XCTAssertTrue(mockHomeVC.invokedEndLoading)
        XCTAssertEqual(mockHomeVC.invokedEndLoadingCount, 1)
    }
    
    func test_dataRefreshed_InvokesViewDataRefreshedLoading() {
        XCTAssertFalse(mockHomeVC.invokedDataRefreshed)
        XCTAssertEqual(mockHomeVC.invokedDataRefreshedCount, 0)
        
        presenter.dataRefreshed()
        
        XCTAssertTrue(mockHomeVC.invokedDataRefreshed)
        XCTAssertEqual(mockHomeVC.invokedDataRefreshedCount, 1)
    }
    
    func test_onError_WithErrorMessage_InvokesViewOnError() {
        XCTAssertFalse(mockHomeVC.invokedOnError)
        XCTAssertEqual(mockHomeVC.invokedOnErrorCount, 0)
        XCTAssertNil(mockHomeVC.invokedOnErrorParameter)
        
        presenter.onError(errorMessage: "error")
        
        XCTAssertTrue(mockHomeVC.invokedOnError)
        XCTAssertEqual(mockHomeVC.invokedOnErrorCount, 1)
        XCTAssertEqual(mockHomeVC.invokedOnErrorParameter, "error")
    }
    
    func test_showProfileImageAndEmail_WithModel_InvokesViewSetUserInfos() {
        XCTAssertFalse(mockHomeVC.invokedSetUserInfos)
        XCTAssertEqual(mockHomeVC.invokedSetUserInfosCount, 0)
        XCTAssertNil(mockHomeVC.invokedSetUserInfosParameter)
        
        let mockModel: CurrentUserModel = .init(profileImageURLString: "image", userEmail: "email")
        presenter.showProfileImageAndEmail(model: mockModel)
        XCTAssertTrue(mockHomeVC.invokedSetUserInfos)
        XCTAssertEqual(mockHomeVC.invokedSetUserInfosCount, 1)
        XCTAssertEqual(mockHomeVC.invokedSetUserInfosParameter, mockModel)
    }
}
