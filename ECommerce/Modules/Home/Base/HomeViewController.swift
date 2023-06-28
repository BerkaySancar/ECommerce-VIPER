//
//  HomeViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func prepareHomeCollectionView()
}

final class HomeViewController: UIViewController {
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    internal var presenter: HomePresenterInputs!
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - HomeView protocols
extension HomeViewController: HomeViewProtocol {
    func prepareHomeCollectionView() {
        view.addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeCollectionView.backgroundColor = .gray
    }
}

// MARK: - Collection View Delegates
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

