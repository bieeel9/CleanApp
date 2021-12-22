//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Gabriel Santos on 22/12/21.
//

import Foundation
import Domain

class AddAccountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completionWithAccount(_ account: AccountModel) {
        completion?(.success(account))
    }
}
