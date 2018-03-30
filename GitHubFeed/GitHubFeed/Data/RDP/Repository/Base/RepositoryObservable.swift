//
//  RepositoryObservable.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Foundation
import RxSwift

public protocol RepositoryObservable {
    associatedtype EntityType
    
    func clear() -> Completable
    func add(item: EntityType) -> Completable
    func add(items: [EntityType]) -> Completable
    func update(item: EntityType) -> Completable
    func remove(item: EntityType) -> Completable
    func remove(items: [EntityType]) -> Completable
    func query(specification: Specification) -> Observable<[EntityType]>
}

extension RepositoryObservable {
    func clear() -> Completable { fatalError() }
    func add(item: EntityType) -> Completable { fatalError() }
    func add(items: [EntityType]) -> Completable { fatalError() }
    func update(item: EntityType) -> Completable { fatalError() }
    func remove(item: EntityType) -> Completable { fatalError() }
    func remove(items: [EntityType]) -> Completable { fatalError() }
    func query(specification: Specification) -> Observable<[EntityType]> { fatalError() }
}

class AnyRepository<T>: RepositoryObservable {
    typealias EntityType = T
    
    private let _add: ((T) -> Completable)
    private let _addItems: (([T]) -> Completable)
    private let _remove: ((T) -> Completable)
    private let _removeItems: (([T]) -> Completable)
    private let _update: ((T) -> Completable)
    private let _clear: (() -> Completable)
    private let _query: ((Specification) -> Observable<[T]>)
    
    init<U: RepositoryObservable>(entityType: U) where U.EntityType == T {
        _add = entityType.add(item:)
        _addItems = entityType.add(items:)
        _remove = entityType.remove(item:)
        _removeItems = entityType.remove(items:)
        _update = entityType.update(item:)
        _clear = entityType.clear
        _query = entityType.query(specification:)
    }
    
    func clear() -> Completable {
        return _clear()
    }
    
    func add(items: [T]) -> Completable {
        return _addItems(items)
    }
    
    func add(item: T) -> Completable {
        return _add(item)
    }
    func update(item: T) -> Completable {
        return _update(item)
    }
    
    func remove(item: T) -> Completable {
        return _remove(item)
    }
    
    func remove(items: [T]) -> Completable {
        return _removeItems(items)
    }
    
    func query(specification: Specification) -> Observable<[T]> {
        return _query(specification)
    }
}
