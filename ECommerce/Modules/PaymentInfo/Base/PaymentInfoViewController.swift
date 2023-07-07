//
//  PaymentInfoViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

protocol PaymentInfoViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func setBackgrodunColor(color: UIColor)
    func preparePlusButton()
    func prepareCollectionView()
    func prepareEmptyCardView()
    func onError(message: String)
    func dataRefreshed()
}

final class PaymentInfoViewController: UIViewController {
    
    private lazy var paymentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        return collectionView
    }()
    
    private lazy var emptyCardView = EmptyCardView()
    
    internal var presenter: PaymentInfoPresenterInputs!

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

// MARK: - View protocols
extension PaymentInfoViewController: PaymentInfoViewProtocol {
    
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func setBackgrodunColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func preparePlusButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    }
    
    func prepareEmptyCardView() {
        view.addSubview(emptyCardView)
        emptyCardView.delegate = self
        
        emptyCardView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func prepareCollectionView() {
        view.addSubview(paymentCollectionView)
        
        paymentCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func onError(message: String) {
        self.showAlert(title: "", message: message)
    }
    
    func dataRefreshed() {
        self.paymentCollectionView.reloadData()
    }
}

// MARK: - EmptyView Button Delegate
extension PaymentInfoViewController: EmptyCardViewButtonDelegate {
    func toAddButtonTapped() {
        presenter.toAddButtonTapped()
    }
}

// MARK: - Cell Button Delegate
extension PaymentInfoViewController: CardCellTrashButtonDelegate {
    func trashTapped(model: CardModel?) {
        presenter.trashTapped(model: model)
    }
}

// MARK: - UI CollectionView Delegates & DataSource
extension PaymentInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyCardView.isHidden = (presenter.numberOfItemsInSection(section: section) == 0) ? false : true
        return presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = paymentCollectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UICollectionViewCell()}
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.cornerRadius = 8
        cell.delegate = self
        cell.showModel(model: presenter.cellForItemAt(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        paymentCollectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
