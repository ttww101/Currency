platform :ios, '9.0'

def setupCommonPods
  
  # Networking
  pod 'Kanna', :git => 'https://github.com/tid-kijyun/Kanna.git', :branch => 'feature/v4.0.0'
  pod 'CSV.swift', '2.3.0'
  pod 'Alamofire', '4.7.3'
  pod 'SwiftyJSON', '4.2.0'
  pod 'ReachabilitySwift', '4.3.0'

  pod 'StatusProvider'
  pod 'ErrorHandler'
  pod 'ErrorHandler/Alamofire'
  pod 'AssistantKit'

  # View
  pod 'Kingfisher', '4.10.0'
  # RAMAnimatedTabBarController not convert to swift 4.0 yet.
  pod 'RAMAnimatedTabBarController', '4.0.2'
  pod 'HidingNavigationBar'
  
  pod 'RoundedSwitch', '2.0.2'
  # pod 'RoundedSwitch', :git => 'https://github.com/lyc2345/Switch.git'
  pod 'DGRunkeeperSwitch', '1.1.4'
  
  pod 'JVFloatLabeledTextField'
  pod 'MGSwipeTableCell'
  pod 'MMPopupView'
  pod 'KVNProgress'
  pod 'SVProgressHUD'
  pod 'NVActivityIndicatorView' 
  #pod 'PagingMenuController'
  pod 'PagingMenuController', :git => 'https://github.com/KoStudio/PagingMenuController.git', :branch => 'master'
  pod 'Hero', '1.4.0'
  #pod 'Cards'

  pod 'SJFluidSegmentedControl', :git => 'https://github.com/sasojadrovski/SJFluidSegmentedControl.git', :branch => 'master'

  # TableView RefreshControll
  pod 'CRRefresh'

  # Chart
  pod 'Charts', '3.2.0'
  
  # File
  pod 'R.swift', '5.0.0'
  
  # Syntax tool
  pod 'Then'
  pod 'SwiftyUserDefaults'
  pod 'SwiftLint'
  pod 'Disk'
  
  # Crash report
  pod 'Fabric'
  pod 'Crashlytics'
  
  # Rate
  pod 'Appirater'
  
  # Color palette
  pod 'Hue'
  
  # Analysis
  # If using use_frameworks! flag, 'Bolts' needs to add before the FBSDKCoreKit dependency.
  # pod 'Bolts'
  # pod 'FBSDKCoreKit'
  # pod 'FBSDKShareKit'
  # pod 'FBSDKLoginKit'

  # AD
  # pod 'mopub-ios-sdk'
  # #pod 'FBAudienceNetwork'
  
  # # AdColony
  # pod 'MoPub-AdColony-Adapters'
  # # AppLovin
  # #pod 'MoPub-Applovin-Adapters'
  # # Chartboost
  # pod 'MoPub-Chartboost-Adapters'
  # # One by AOL
  # # The MoPub Mediation Integration Tool no longer distributes the CocoaPods configuration for One by AOL.
  # # To mediate AOL, download the adapters from https://github.com/mopub/mopub-ios-mediation/tree/master/OnebyAOL and the SDK binary from http://docs.onemobilesdk.aol.com/ios-ad-sdk/
  # # Google (AdMob)
  # pod 'MoPub-AdMob-Adapters'
  # # Facebook Audience Network
  # pod 'MoPub-FacebookAudienceNetwork-Adapters'
  # # Tapjoy
  # pod 'MoPub-TapJoy-Adapters'
  # # Unity Ads
  # pod 'MoPub-UnityAds-Adapters'
  # # Vungle
  # pod 'MoPub-Vungle-Adapters'
  # # AdColony
  # pod 'MoPub-AdColony-Adapters'
  # # ironSource
  # pod 'MoPub-IronSource-Adapters'
  # # Yahoo! Flurry
  # pod 'MoPub-Flurry-Adapters'
  
end

def setupTestPods
  
  # File
  setupCommonPods

  # Test framework
  pod 'Quick'
  pod 'Nimble'
  pod 'Fleet', '~> 4.1'
  
end

def setupiOSProject
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      # set which target not support swift 4 yet, e.g. PagingMenuController is only supported swift version 3.2
      # if ['PagingMenuController', 'SJFluidSegmentedControl'].include? target.name
      #   target.build_configurations.each 
      #   do |config|
      #     config.build_settings['SWIFT_VERSION'] = '3.2'
      #     config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      #   end
      #   else
      #   target.build_configurations.each do |config|
      #     config.build_settings['SWIFT_VERSION'] = '4.0'
      #   end
      # end
    end
  end
end


target 'CURRENCY' do

  use_frameworks!
  
  setupCommonPods
  
  setupiOSProject
  
end

