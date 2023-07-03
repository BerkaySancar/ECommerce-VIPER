//
//  BasketInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import Foundation

protocol BasketInteractorInputs {
    
}

protocol BasketInteractorOutputs: AnyObject {
    
}

final class BasketInteractor {
    weak var presenter: BasketInteractorOutputs?
}

extension BasketInteractor: BasketInteractorInputs {
    
}
