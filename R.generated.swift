//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `README`.
    static let readmE = Rswift.FileResource(bundle: R.hostingBundle, name: "README", pathExtension: "")
    
    /// `bundle.url(forResource: "README", withExtension: "")`
    static func readmE(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.readmE
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `JCollectionViewItemCell`.
    static let jCollectionViewItemCell = _R.nib._JCollectionViewItemCell()
    /// Nib `JLearnMoreCell`.
    static let jLearnMoreCell = _R.nib._JLearnMoreCell()
    
    /// `UINib(name: "JCollectionViewItemCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.jCollectionViewItemCell) instead")
    static func jCollectionViewItemCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.jCollectionViewItemCell)
    }
    
    /// `UINib(name: "JLearnMoreCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.jLearnMoreCell) instead")
    static func jLearnMoreCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.jLearnMoreCell)
    }
    
    static func jCollectionViewItemCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> JCollectionViewItemCell? {
      return R.nib.jCollectionViewItemCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? JCollectionViewItemCell
    }
    
    static func jLearnMoreCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> JLearnMoreCell? {
      return R.nib.jLearnMoreCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? JLearnMoreCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 8 localization keys.
    struct localizable {
      /// en translation: Chinese(Simplified)
      /// 
      /// Locales: en, zh-Hans
      static let languagesChineseHans = Rswift.StringResource(key: "Languages.ChineseHans", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: Chooses language, current is 
      /// 
      /// Locales: en, zh-Hans
      static let languagesSectionTitle = Rswift.StringResource(key: "Languages.SectionTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: English
      /// 
      /// Locales: en, zh-Hans
      static let languagesEnglish = Rswift.StringResource(key: "Languages.English", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: Follow System
      /// 
      /// Locales: en, zh-Hans
      static let languagesFollowSystem = Rswift.StringResource(key: "Languages.FollowSystem", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: Italian
      /// 
      /// Locales: en, zh-Hans
      static let languagesItalian = Rswift.StringResource(key: "Languages.Italian", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans"], comment: nil)
      /// en translation: Login
      /// 
      /// Locales: en, zh-Hans, it
      static let userProfileSettingsLogin = Rswift.StringResource(key: "UserProfile.Settings.Login", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans", "it"], comment: nil)
      /// en translation: Logout
      /// 
      /// Locales: en, zh-Hans, it
      static let userProfileSettingsLogout = Rswift.StringResource(key: "UserProfile.Settings.Logout", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans", "it"], comment: nil)
      /// en translation: Settings
      /// 
      /// Locales: en, zh-Hans, it
      static let userProfileSettingsSettings = Rswift.StringResource(key: "UserProfile.Settings.Settings", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hans", "it"], comment: nil)
      
      /// en translation: Chinese(Simplified)
      /// 
      /// Locales: en, zh-Hans
      static func languagesChineseHans(_: Void = ()) -> String {
        return NSLocalizedString("Languages.ChineseHans", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Chooses language, current is 
      /// 
      /// Locales: en, zh-Hans
      static func languagesSectionTitle(_: Void = ()) -> String {
        return NSLocalizedString("Languages.SectionTitle", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: English
      /// 
      /// Locales: en, zh-Hans
      static func languagesEnglish(_: Void = ()) -> String {
        return NSLocalizedString("Languages.English", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Follow System
      /// 
      /// Locales: en, zh-Hans
      static func languagesFollowSystem(_: Void = ()) -> String {
        return NSLocalizedString("Languages.FollowSystem", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Italian
      /// 
      /// Locales: en, zh-Hans
      static func languagesItalian(_: Void = ()) -> String {
        return NSLocalizedString("Languages.Italian", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Login
      /// 
      /// Locales: en, zh-Hans, it
      static func userProfileSettingsLogin(_: Void = ()) -> String {
        return NSLocalizedString("UserProfile.Settings.Login", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Logout
      /// 
      /// Locales: en, zh-Hans, it
      static func userProfileSettingsLogout(_: Void = ()) -> String {
        return NSLocalizedString("UserProfile.Settings.Logout", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Settings
      /// 
      /// Locales: en, zh-Hans, it
      static func userProfileSettingsSettings(_: Void = ()) -> String {
        return NSLocalizedString("UserProfile.Settings.Settings", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _JCollectionViewItemCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "JCollectionViewItemCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> JCollectionViewItemCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? JCollectionViewItemCell
      }
      
      fileprivate init() {}
    }
    
    struct _JLearnMoreCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "JLearnMoreCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> JLearnMoreCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? JLearnMoreCell
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Main"
      let viewController = StoryboardViewControllerResource<ViewController>(identifier: "ViewController")
      
      func viewController(_: Void = ()) -> ViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().viewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewController' could not be loaded from storyboard 'Main' as 'ViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
