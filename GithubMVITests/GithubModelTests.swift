//
//  GithubModelTests.swift
//  GithubMVITests
//
//  Created by Dinesh IIINC on 24/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation
import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import GithubMVI

class GithubModelTests: XCTestCase {

  override func setUp() {

  }

  func testEmitsInitialState_whenViewCreated() {

    // Setup
    let disposeBag = DisposeBag()
    let observer: TestableObserver<GithubState> = TestScheduler(initialClock: 0)
      .createObserver(GithubState.self)

    let lifecycle = PublishRelay<MviLifecycle>()

    let userInputs = PublishRelay<String>()
    let intensions = Intentions(userInputs.asObservable())

    GithubModel
      .bind(lifecycle.asObservable(), intensions)
      .subscribe(observer)
      .disposed(by: disposeBag)

    // Act
    lifecycle.accept(.created)

    // Assert
    let expectedStates = [next(0, GithubState(userInput: "", repos: [], summary: .none))]
    XCTAssertEqual(observer.events, expectedStates)
  }

  func testEmitsLoadingState_whenUserInputsQuery() {
    let disposeBag = DisposeBag()
    let schedular = TestScheduler(initialClock: 0)
    let lifecycle = PublishRelay<MviLifecycle>()
    let userInputs = PublishRelay<String>()
    let intensions = Intentions(userInputs.asObservable())

    let observer = schedular.createObserver(GithubState.self)
    GithubModel.bind(lifecycle.asObservable(), intensions)
                .subscribe(observer)
                .disposed(by: disposeBag)
    
    lifecycle.accept(.created)
    userInputs.accept("A")
    //Assert
    let expectedState = [next(0, GithubState(userInput: "", repos: [], summary: .none)),
                         next(0, GithubState(userInput: "A", repos: [], summary: .inProgress))
                        ]
    XCTAssertEqual(observer.events, expectedState)
  }
}
