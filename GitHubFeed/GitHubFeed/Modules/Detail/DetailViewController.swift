//
//  DetailViewController.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 12/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit

class DetailViewController: BaseRxViewController, DetailContractView {
    
    var eventModel: EventModel!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let propertiesWithValues = getPropertiesWithValuesFor(reflectable: eventModel.event?.payload) as PropertiesWithValues! {
            _ = propertiesWithValues.map { generateTextFor(propertyWithValue: $0) }
        }
    }
    
    private func getPropertiesWithValuesFor(reflectable: Reflectable?) -> PropertiesWithValues? {
        if let propertiesWithValues = reflectable?.getPropertiesWithValues() as PropertiesWithValues! {
            return getPropertiesWithValues(propertiesWithValues)
        }
        return nil
    }
    
    private func getPropertiesWithValues(_ newPropertiesWithValues: PropertiesWithValues) -> PropertiesWithValues? {
        var propertiesWithValues = [(String, Any)]()
        
        func getPropertiesWithValuesForDescendant(reflectable: Reflectable, key: String) {
            if let descendantPropertiesWithValues = getPropertiesWithValuesFor(reflectable: reflectable) as PropertiesWithValues! {
                propertiesWithValues.append((key, descendantPropertiesWithValues))
            }
        }
        
        for propertyWithValue in newPropertiesWithValues {
            let key = propertyWithValue.0
            let value = propertyWithValue.1
            if let reflectables = value as? [Reflectable] {
                for reflectable in reflectables {
                    getPropertiesWithValuesForDescendant(reflectable: reflectable, key: key)
                }
            } else if let reflectable = value as? Reflectable {
                getPropertiesWithValuesForDescendant(reflectable: reflectable, key: key)
            } else {
                propertiesWithValues.append((key, value))
            }
        }
        return propertiesWithValues
    }

    private func generateTextFor(propertyWithValue: PropertyWithValue) {
        var stringKeyValues = Reflectable.getStringKeyValuesAndFlattenStructureIfNecessary(propertyWithValue: propertyWithValue)
        if stringKeyValues.count > 1 {
            stringKeyValues.insert(StringKeyValue(String().newLineCharacter(),
                                           String().newLineCharacter()), at: 0)
        }
        for stringKeyValue in stringKeyValues {
            displayTextFromStringKeyValue(stringKeyValue: StringKeyValue(stringKeyValue.0,
                                                                         stringKeyValue.1))
        }
    }
    
    private func displayTextFromStringKeyValue(stringKeyValue: StringKeyValue) {
        let formattedString = NSMutableAttributedString(attributedString: textView.attributedText)
        if stringKeyValue.0.isEmpty || stringKeyValue.1.isEmpty {
            return
        } else if stringKeyValue.0 == String().newLineCharacter() && stringKeyValue.1 == String().newLineCharacter() {
            formattedString
                .normal(String().newLineCharacter())
                .normal(String().newLineCharacter())
        } else {
            formattedString
                .bold(stringKeyValue.0)
                .bold(String().colonSeparator())
                .normal(stringKeyValue.1)
                .normal(String().newLineCharacter())
        }
        textView.attributedText = formattedString
    }

    override func createPresenters() -> [ViperRxPresenter] {
        return [DetailPresenter<DetailInteractor, DetailRouting, DetailViewController>()]
    }
}
