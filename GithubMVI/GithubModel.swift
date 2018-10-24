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
    _ lifecycle: Observable<MviLifecycle>
  ) -> Observable<GithubState> {

    let lifecycleCreatedState = lifecycleCreateduseCase(lifecycle)

    return lifecycleCreatedState
  }

  static func lifecycleCreateduseCase(
    _ lifecycle: Observable<MviLifecycle>
  ) -> Observable<GithubState> {
    return lifecycle
      .filter { lifecycle in lifecycle == .created }
      .map { (lifecycle) -> GithubState in
        return GithubState.initialState()
      }
  }
}
