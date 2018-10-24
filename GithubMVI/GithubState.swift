//
//  GithubState.swift
//  GithubMVI
//
//  Created by Dinesh IIINC on 24/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation

struct Repository: Equatable {

  static func == (lhs: Repository, rhs: Repository) -> Bool {
    return true
  }
}

struct GithubState: Equatable {

  enum Summary {
    case none
    case inProgress
    case success
    case faliure
  }

  var userInput: String
  var repos: [Repository]
  var summary: Summary

  static func == (lhs: GithubState, rhs: GithubState) -> Bool {
    return (
        lhs.userInput == rhs.userInput &&
        lhs.repos == rhs.repos &&
        lhs.summary == rhs.summary
    )
  }
}

extension GithubState {

  static func initialState() -> GithubState {
    return GithubState(userInput: "", repos: [], summary: .none)
  }
}
