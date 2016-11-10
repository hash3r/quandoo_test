platform :ios, '9.0'

use_frameworks!

target 'Quandoo_test' do
	pod 'Alamofire'
	pod 'AlamofireObjectMapper'
    pod 'SwiftyJSON'
    pod 'HTTPStatusCodes'
    pod 'PromiseKit/CorePromise'
    pod 'PromiseKit/UIKit'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
