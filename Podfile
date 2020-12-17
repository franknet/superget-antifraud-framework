platform :ios, '12.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/goinstant/pods-specs-public'
source 'https://bitbucket.getnet.com.br/scm/sgm/podspecs.git'

def shared_pods
  use_frameworks!
  pod 'Alamofire', '5.3.0'
  pod 'RxSwift'
  pod 'SwiftGen', '~> 6.0'
  pod 'AppAuth'
  pod 'SwiftKeychainWrapper'
  pod 'JVFloatLabeledTextField'
  pod 'RxGesture'
  pod 'IQKeyboardManagerSwift'
  pod 'TrustKit'
  pod 'SkeletonView'
  pod 'FittedSheets', '~> 1'
end

target 'Getpay-Core' do
  shared_pods

  target 'Getpay-CoreTests' do
    inherit! :search_paths
    shared_pods
    # Pods for testing
  end

end
