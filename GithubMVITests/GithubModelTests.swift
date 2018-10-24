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

  func testEmitsInitialState_whenViewCreated() {

    // Setup
    let disposeBag = DisposeBag()
    let observer: TestableObserver<GithubState> = TestScheduler(initialClock: 0)
      .createObserver(GithubState.self)

    let lifecycle = PublishRelay<MviLifecycle>()

    GithubModel
      .bind(lifecycle.asObservable())
      .subscribe(observer)
      .disposed(by: disposeBag)

    lifecycle.accept(.created)

    // Assert
    let expectedStates = [next(0, GithubState(userInput: "", repos: [], summary: .none))]
    XCTAssertEqual(observer.events, expectedStates)
  }
}
