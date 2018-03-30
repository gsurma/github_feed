//
//  Reflectable.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 16/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Foundation

class Reflectable {
    
    func getPropertiesWithValues() -> PropertiesWithValues {
        var propertiesWithValues = PropertiesWithValues()
        for child in Mirror(reflecting: self).children {
            if let propertyName = child.label as String! {
                propertiesWithValues.append((propertyName, child.value))
            }
        }
        return propertiesWithValues
    }
    
    class func getStringKeyValuesAndFlattenStructureIfNecessary(propertyWithValue: PropertyWithValue) -> [StringKeyValue] {
        let key = propertyWithValue.0
        let value = propertyWithValue.1
        var localStringKeyValues = [StringKeyValue]()
        var stringValue = ""
        switch value {
        case is String:
            stringValue = value as! String
        case is Int:
            stringValue = String(value as! Int)
        case is Float:
            stringValue = String(value as! Float)
        case is Bool:
            stringValue = String(value as! Bool)
        case is [(String, Any)]:
            let array = (value as! [(String, Any)])
            for element in array {
                if let newStringKeyValues = getStringKeyValuesAndFlattenStructureIfNecessary(propertyWithValue: PropertyWithValue(element.0, element.1)) as [StringKeyValue]! {
                    localStringKeyValues.append(contentsOf: newStringKeyValues)
                }
            }
        default:
            break
        }
        if localStringKeyValues.isEmpty {
            localStringKeyValues.append(StringKeyValue(key, stringValue))
        }
        return localStringKeyValues
    }
}
