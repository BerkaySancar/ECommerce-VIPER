//
//  UserProfileInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation

protocol ProfileInteractorInputs {
    
}

protocol ProfileInteractorOutputs: AnyObject {
    
}

final class ProfileInteractor {
    weak var presenter: ProfileInteractorOutputs?
}

extension ProfileInteractor: ProfileInteractorInputs {
    
}
