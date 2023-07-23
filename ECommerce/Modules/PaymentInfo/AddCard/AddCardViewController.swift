//
//  AddCardViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

extension Notification.Name {
    static let cardAddButtonNotification = Notification.Name(rawValue: "CardAddButtonNotification")
}

final class AddCardViewController: UIViewController {

    @IBOutlet private weak var nameSurnameTextField: UITextField!
    @IBOutlet private weak var cardNameTextField: UITextField!
    @IBOutlet private weak var cardNumberTextField: UITextField!
    @IBOutlet private weak var monthTextField: UITextField!
    @IBOutlet private weak var yearTextField: UITextField!
    @IBOutlet private weak var cvvTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    
    private let userInfoManager = UserInfoManager()
    private let notificationCenter = NotificationCenter.default
    
    private var card: CardModel?
    
    init(card: CardModel?) {
        self.card = card
        super.init(nibName: "AddCardView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWithModel()
    }
    
    private func setupWithModel() {
        if card != nil {
            nameSurnameTextField.text = card?.nameSurname
            cardNameTextField.text = card?.cardName
            cardNumberTextField.text = card?.cardNumber
            monthTextField.text = card?.month
            yearTextField.text = card?.year
            cvvTextField.text = card?.cvv
            addButton.setTitle("Update", for: .normal)
        }
    }

    @IBAction func addUpdateButtonTapped(_ sender: Any) {
        
        defer {
            self.navigationController?.popViewController(animated: true)
        }
        
        if
            let nameSurname = nameSurnameTextField.text,
            let cardName = cardNameTextField.text,
            let cardNumber = cardNumberTextField.text,
            let month = monthTextField.text,
            let year = yearTextField.text,
            let cvv = cvvTextField.text,
            !nameSurname.isEmpty,
            !cardName.isEmpty,
            !cardNumber.isEmpty,
            !month.isEmpty,
            !year.isEmpty,
            !cvv.isEmpty
                
            {
            
            let cardInfos: [String: AnyHashable] = ["userId": userInfoManager.getUserUid(),
                                                    "uuid": self.card?.uuid ?? UUID().uuidString,
                                                    "nameSurname": nameSurname,
                                                    "cardName": cardName,
                                                    "month": month,
                                                    "year": year,
                                                    "cvv": cvv,
                                                    "cardNumber": cardNumber]
            
            let action = addButton.titleLabel?.text == "Add" ? "add" : "update"
            let cardInfoForNC: [String: Any] = ["card": cardInfos, "action": action]
            notificationCenter.post(name: .cardAddButtonNotification, object: nil, userInfo: cardInfoForNC)
        } else {
            self.showAlert(title: "", message: GeneralError.addressInfoMissing.localizedDescription)
        }
    }
}
