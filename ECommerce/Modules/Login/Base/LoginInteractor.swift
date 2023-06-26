//
//  LoginInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol LoginInteractorInputs {
    
}

protocol LoginInteractorOutputs: AnyObject {
    
}

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputs?
    
}

extension LoginInteractor: LoginInteractorInputs {
    
}
