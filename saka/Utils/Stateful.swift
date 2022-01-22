//
//  Stateful.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation

enum Stateful<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
