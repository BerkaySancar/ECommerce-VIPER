//
//  CompleteOrderViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

protocol CompleteOrderViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func setBackgroundColor(color: UIColor)
    func setTabBarVisibility()
    func prepareCollectionView()
    func prepareCompleteButton()
    func dataRefreshed()
}

final class CompleteOrderViewController: UIViewController {
    
    internal var presenter: CompleteOrderPresenterInputs!
    
    private lazy var completeOrderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddressInfoCell.self, forCellWithReuseIdentifier: AddressInfoCell.identifier)
        collectionView.register(CardInfoCell.self, forCellWithReuseIdentifier: CardInfoCell.identifier)
        collectionView.register(TotalPriceCell.self, forCellWithReuseIdentifier: TotalPriceCell.identifier)
        return collectionView
    }()
    
    private lazy var completeOrderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 8
        button.setTitle("Complete Order", for: .normal)
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    @objc private func completeButtonTapped() {
        presenter.completeButtonTapped()
    }
}

extension CompleteOrderViewController: CompleteOrderViewProtocol {
    
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func setBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func setTabBarVisibility() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func prepareCollectionView() {
        view.addSubview(completeOrderCollectionView)
        completeOrderCollectionView.backgroundColor = .systemGray6
        
        completeOrderCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(completeOrderButton.snp.top).inset(-16)
        }
    }
    
    func prepareCompleteButton() {
        view.addSubview(completeOrderButton)
        
        completeOrderButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.centerY.equalTo(view.frame.height / 1.1)
        }
    }
    
    func dataRefreshed() {
        completeOrderCollectionView.reloadData()
    }
}

extension CompleteOrderViewController: CardInfoCellButtonDelegate {
    func addUpdateTapped() {
        presenter.addUpdateTappedFromCards()
    }
}

extension CompleteOrderViewController: AddressInfoCellButtonDelegate {
    func addUpdateTappedFromAddress() {
        presenter.addUpdateTappedFromAddresses()
    }
}

extension CompleteOrderViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = completeOrderCollectionView.dequeueReusableCell(withReuseIdentifier: AddressInfoCell.identifier, for: indexPath) as? AddressInfoCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = 8
            cell.layer.shadowOpacity = 0.2
            cell.delegate = self
            cell.showAddres(addresses: presenter.cellForItemAt(indexPath: indexPath) as? [AddressModel])
            return cell
        } else if indexPath.section == 1 {
            guard let cell = completeOrderCollectionView.dequeueReusableCell(withReuseIdentifier: CardInfoCell.identifier, for: indexPath) as? CardInfoCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = 8
            cell.layer.shadowOpacity = 0.2
            cell.delegate = self
            cell.showCards(cards: presenter.cellForItemAt(indexPath: indexPath) as? [CardModel])
            return cell
        } else {
            guard let cell = completeOrderCollectionView.dequeueReusableCell(withReuseIdentifier: TotalPriceCell.identifier, for: indexPath) as? TotalPriceCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = 8
            cell.layer.shadowOpacity = 0.2
            cell.showModel(model: presenter.showTotalAndDeliveryPrice())
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
