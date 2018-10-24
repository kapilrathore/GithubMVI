//
//  Intentions.swift
//  GithubMVI
//
//  Created by Dinesh IIINC on 24/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Intentions {
  private var  input: Observable<String>
  init(_ userInput: Observable<String>) {
    self.input = userInput
  }

  func userInput() -> Observable<String> {
    return input
  }
}

extension Intentions {

}
