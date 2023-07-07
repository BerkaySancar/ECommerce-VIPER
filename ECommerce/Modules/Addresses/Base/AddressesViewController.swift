//
//  AddressesViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import UIKit

protocol AddressesViewProtocol: AnyObject {
    func setViewBackgroundColor(color: UIColor)
    func setNavBarTitle(title: String)
    func prepareCollectionView()
    func prepareEmptyView()
    func preparePlusButton()
    func dataRefreshed()
    func onError(message: String)
}

final class AddressesViewController: UIViewController {
    
    private lazy var addressesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: AddressCell.identifier)
        return collectionView
    }()
    
    private lazy var emptyView = EmptyAddressesView()
    
    internal var presenter: AddressesPresenterInputs!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

// MARK: - Actions
    @objc
    private func plusButtonTapped() {
        presenter.plusButtonTapped()
    }

}

// MARK: - View protocol
extension AddressesViewController: AddressesViewProtocol {
    func setViewBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func setNavBarTitle(title: String) {
        self.title = title
    }
    
    func prepareCollectionView() {
        view.addSubview(addressesCollectionView)
        
        addressesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func prepareEmptyView() {
        view.addSubview(emptyView)
        emptyView.delegate = self
        
        emptyView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func preparePlusButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    }
    
    func dataRefreshed() {
        self.addressesCollectionView.reloadData()
    }
    
    func onError(message: String) {
        self.showAlert(title: "", message: message)
    }
}

// MARK: - EmptyAdressView button delegate
extension AddressesViewController: EmptyAddressesViewButtonDelegate {
    func toAddButtonTapped() {
        presenter.toAddButtonTapped()
    }
}

extension AddressesViewController: AddressCellTrashButtonDelegate {
    func trashTapped(model: AddressModel?) {
        presenter.trashTapped(model: model)
    }
}

// MARK: CollectionView Delegate&DataSource
extension AddressesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyView.isHidden = (presenter.numberOfItemsInSection(section: section) == 0) ? false : true
        return presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = addressesCollectionView.dequeueReusableCell(withReuseIdentifier: AddressCell.identifier, for: indexPath) as? AddressCell else { return UICollectionViewCell() }
        
        cell.showModel(model: presenter.cellForItemAt(indexPath: indexPath))
        cell.delegate = self
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addressesCollectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
