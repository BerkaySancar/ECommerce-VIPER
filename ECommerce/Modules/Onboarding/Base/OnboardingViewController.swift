//
//  OnboardingViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func setupConstraints()
    func scrollToNextItem()
}

final class OnboardingViewController: UIViewController {
    
    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardCell.self, forCellWithReuseIdentifier: OnboardCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
   
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.layer.cornerRadius = 8
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.numberOfPages = 3
        return pageControl
    }()
       
    var presenter: OnboardingPresenterInputs!

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - CollectionView Delegates
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardCell.identifier, for: indexPath) as? OnboardCell else { return UICollectionViewCell() }
        cell.showModel(model: presenter.cellForItemAtIndexPath(indexPath: indexPath))
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.2)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = pageIndex
    }
}

// MARK: - Onboarding View Protocol
extension OnboardingViewController: OnboardingViewProtocol {
    
    func setupConstraints() {
        view.addSubview(onboardingCollectionView)
        view.addSubview(pageControl)
   
        onboardingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(72)
            make.left.equalToSuperview().offset(8)
            make.height.equalTo(20)
            make.width.equalTo(120)
        }
    }
    
    func scrollToNextItem() {
        let currentIndexPath = onboardingCollectionView.indexPathsForVisibleItems.first
        if let currentIndexPath {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: currentIndexPath.section)
            onboardingCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - Cell Button Delegate
extension OnboardingViewController: OnboardCellButtonDelegate {
    func nextStartButtonTapped(title: String) {
        pageControl.currentPage += 1
        presenter.cellNextStartButtonTapped(title: title)
    }
}
