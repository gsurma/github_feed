//
//  BaseRx.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.

import RxSwift

class BaseRx {
    var compositeDisposable = CompositeDisposable()

    func addSubscription(subscription: Disposable?) {
        guard subscription != nil else {
            return
        }
        _ = compositeDisposable.insert(subscription!)
    }
}
