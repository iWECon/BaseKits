platform :ios, '9.0'
use_frameworks!

target 'IWBaseKits' do
#   消除警告
inhibit_all_warnings!
    
# Rx
pod 'RxSwift', '~> 5.0.0'
pod 'RxCocoa', '~> 5.0.0'
pod 'NSObject+Rx', '~> 5.0.0'   # https://github.com/RxSwiftCommunity/NSObject-Rx
pod 'RxSwiftExt', '~> 5.0.0'    # https://github.com/RxSwiftCommunity/RxSwiftExt


# Tools
pod 'R.swift', '~> 5.0.3'       # https://github.com/mac-cain13/R.swift
pod 'Localize-Swift', '~> 2.0'  # https://github.com/marmelroy/Localize-Swift

# TableView & CollectionView
pod 'RxDataSources', '~> 4.0.1' # https://github.com/RxSwiftCommunity/RxDataSources
pod 'KafkaRefresh', '~> 1.4.0'  # https://github.com/OpenFeyn/KafkaRefresh
pod 'CollectionKit’


# Network
pod 'Moya/RxSwift', '~> 14.0.0-alpha.1' # https://github.com/Moya/Moya
pod 'ReachabilitySwift', '~> 4.0' # https://github.com/ashleymills/Reachability.swift


# Model
# for Xcode 10.2
pod 'HandyJSON', :tag=> '5.0.0-beta.1', :git => 'https://github.com/alibaba/HandyJSON'     # https://github.com/alibaba/HandyJSON
# for Xcode 10.1
#pod 'HandyJSON', '= 4.2.0'

# layout
pod 'SnapKit', '~> 4.2.0'       # https://github.com/SnapKit/SnapKit


# Log 日志
pod 'CocoaLumberjack/Swift'


# Then/do 继续/do something
pod 'Then', '~> 2.4.0'          # https://github.com/devxoul/Then


end


# Cocoapods optimization, always clean project after pod updating
post_install do |installer|
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
    
    # enable tracing resources
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end
