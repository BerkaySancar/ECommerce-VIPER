//
//  MockHomeViewController.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 25.07.2023.
//

import Foundation
@testable import ECommerce
import UIKit.UIColor

final class MockHomeViewController: HomeViewProtocol {
    
    var invokedSetViewBgColor = false
    var invokedSetViewBgColorCout = 0
    var invokedSetViewBgColorParameter: UIColor?
    func setViewBackgroundColor(color: UIColor) {
        invokedSetViewBgColor = true
        invokedSetViewBgColorCout += 1
        invokedSetViewBgColorParameter = color
    }
    
    var invokedPrepareNavBarView = false
    var invokedPrepareNavBarViewCount = 0
    func prepareNavBarView() {
        invokedPrepareNavBarView = true
        invokedPrepareNavBarViewCount += 1
    }
    
    var invokedSetNavTabVisibility = false
    var invokedSetNavTabVisibilityCount = 0
    func setNavBarAndTabBarVisibility() {
        invokedSetNavTabVisibility = true
        invokedSetNavTabVisibilityCount += 1
    }
    
    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0
    func prepareSearchBar() {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
    }
    
    var invokedPrepareHomeCollectionView = false
    var invokedPrepareHomeCollectionViewCount = 0
    func prepareHomeCollectionView() {
        invokedPrepareHomeCollectionView = true
        invokedPrepareHomeCollectionViewCount += 1
    }
    
    var invokedPrepareAIV = false
    var invokedPrepareAIVCount = 0
    func prepareActivtyIndicatorView() {
        invokedPrepareAIV = true
        invokedPrepareAIVCount += 1
    }
    
    var invokedStartLoading = false
    var invokedStartLoadingCount = 0
    func startLoading() {
        invokedStartLoading = true
        invokedStartLoadingCount += 1
    }
    
    var invokedEndLoading = false
    var invokedEndLoadingCount = 0
    func endLoading() {
        invokedEndLoading = true
        invokedEndLoadingCount += 1
    }
    
    var invokedDataRefreshed = false
    var invokedDataRefreshedCount = 0
    func dataRefreshed() {
        invokedDataRefreshed = true
        invokedDataRefreshedCount += 1
    }
    
    var invokedOnError = false
    var invokedOnErrorCount = 0
    var invokedOnErrorParameter: String?
    func onError(message: String) {
        invokedOnError = true
        invokedOnErrorCount += 1
        invokedOnErrorParameter = message
    }
    
    var invokedSetUserInfos = false
    var invokedSetUserInfosCount = 0
    var invokedSetUserInfosParameter: CurrentUserModel?
    func setProfileImageAndUserEmail(model: ECommerce.CurrentUserModel) {
        invokedSetUserInfos = true
        invokedSetUserInfosCount += 1
        invokedSetUserInfosParameter = model
    }
}
