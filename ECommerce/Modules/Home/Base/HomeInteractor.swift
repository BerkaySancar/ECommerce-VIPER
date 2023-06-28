//
//  HomeInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

protocol HomeInteractorInputs {
    
}

protocol HomeInteractorOutputs: AnyObject {
    
}

final class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
}

extension HomeInteractor: HomeInteractorInputs {
    
}
