//
//  AddAccount.swift
//  Domain
//
//  Created by Gabriel Santos on 19/10/21.
//

import Foundation

public protocol AddAccount {
    typealias AddAccountResult = Swift.Result<AccountModel, DomainError>
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccountResult) -> Void)
}

public struct AddAccountModel: Model {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
