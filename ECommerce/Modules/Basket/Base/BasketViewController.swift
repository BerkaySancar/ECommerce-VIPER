//
//  BasketViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import UIKit

protocol BasketViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func setBackgroundColor(color: UIColor)
    func prepareBasketTableView()
    func prepareActivtyIndicatorView()
    func prepareCustomBottomView()
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(message: String)
    func calculateTotalPrice(price: Double)
}

final class BasketViewController: UIViewController {
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        return tableView
    }()
    
    private lazy var customBottomView = BasketBottomView()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    internal var presenter: BasketPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension BasketViewController: BasketViewProtocol {

    func setNavTitle(title: String) {
        self.title = title
    }
    
    func setBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
 
    func prepareCustomBottomView() {
        view.addSubview(customBottomView)
        customBottomView.delegate = self
        
        customBottomView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height / 4.20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func prepareBasketTableView() {
        view.addSubview(basketTableView)
        
        basketTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(customBottomView.snp.top)
        }
    }

    func prepareActivtyIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func endLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func dataRefreshed() {
        basketTableView.reloadData()
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
    
    func calculateTotalPrice(price: Double) {
        customBottomView.fixTotalPrice(price: price)
    }
}

extension BasketViewController: BasketBottomViewButtonDelegate {
    func continueShoppingTapped() {
        presenter.continueShoppingTapped()
    }
    
    func completePaymentTapped() {
        presenter.completePaymentTapped()
    }
}

extension BasketViewController: BasketCellStepperCountDelegate {
    func stepperValueChanged(value: Double, item: BasketModel?) {
        presenter.stepperValueChanged(value: value, item: item)
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as? BasketCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.showModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt(indexPath: indexPath)
    }
}
