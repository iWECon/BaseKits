//
//  LanguageModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/9.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxDataSources

class LanguageCellViewModel: NSObject {
    var name: String?
    var mark: String!
    var isSelected: Bool = false
    init(_ lang: String, isSelected: Bool = false) {
        super.init()
        
        self.mark = lang
        self.isSelected = isSelected
        self.name = displayName(forLanguage: lang)
    }
    
    func displayName(forLanguage language: String) -> String {
        if language == "system" {
            return R.string.localizable.languagesFollowSystem.key.localized()
        }
        let local = Locale(identifier: language)
        if let displayName = local.localizedString(forIdentifier: language) {
            return displayName.capitalized(with: local)
        }
        return String()
    }

}

enum LanguageSection {
    case languages(title: String, items: [LanguageSectionItem])
}
enum LanguageSectionItem {
    case languageItem(viewModel: LanguageCellViewModel)
}

extension LanguageSection: Differentiator.SectionModelType {
    typealias Item = LanguageSectionItem
    
    init(original: LanguageSection, items: [Item]) {
        switch original {
        case .languages(let title, let items):
            self = .languages(title: title, items: items)
        }
    }
    
    var title: String {
        switch self {
        case .languages(let title, _):
            return title
        }
    }
    
    var items: [LanguageSectionItem] {
        switch self {
        case .languages(_, let items): return items.map({ $0 })
        }
    }
}
