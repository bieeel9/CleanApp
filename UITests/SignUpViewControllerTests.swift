//
//  UITests.swift
//  UITests
//
//  Created by Gabriel Santos on 22/12/21.
//

import XCTest
import UIKit
import Presentation

@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_at_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_save_button_calls_signUp_on_tap() {
        var callCount = 0
        let signUpSpy: (SignUpViewModel) -> Void = { _ in
            callCount += 1
        }
        let sut = makeSut(signUpSpy: signUpSpy)
        
        sut.saveButton?.simulateTap()
        
        XCTAssertEqual(callCount, 1)
    }
}

extension SignUpViewControllerTests {
    
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUpViewController", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}