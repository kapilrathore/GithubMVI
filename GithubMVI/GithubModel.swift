//
//  GithubModel.swift
//  GithubMVI
//
//  Created by Dinesh IIINC on 24/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation
import RxSwift

class GithubModel {

  static func bind(
    _ lifecycle: Observable<MviLifecycle>, _ intentions: Intentions
  ) -> Observable<GithubState> {
    
    let lifecycleCreatedState = lifecycleCreatedUseCase(lifecycle)

    let userInputStates = userInputUseCase(intentions)

    return Observable.merge(lifecycleCreatedState, userInputStates)
  }

  static func lifecycleCreatedUseCase(
    _ lifecycle: Observable<MviLifecycle>
  ) -> Observable<GithubState> {
    return lifecycle
      .filter { lifecycle in lifecycle == .created }
      .map { (lifecycle) -> GithubState in
        return GithubState.initialState()
      }
  }

  static func userInputUseCase(_ intentions: Intentions) -> Observable<GithubState> {
    return Observable.deferred({ () -> Observable<GithubState> in
      Observable.just(GithubState(userInput: "A", repos: [], summary: .inProgress))
    })

    // return Observable.just(GithubState(userInput: "A", repos: [], summary: .inProgress))
  }
}
