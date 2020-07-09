
Pod::Spec.new do |spec|


  spec.module_name  = "GetpayCore"
  spec.name         = "Getpay-Core"
  spec.version      = "6.6.3"
  spec.summary      = "A Getnet framework."
  spec.homepage     = "https://www.superget.com.br/"

  spec.description  = "GetpayCore is customized and present some views with state of payments."

  #spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Leandro dos Santos Lopes" => "lslopes.dev@gmail.com" }

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://bitbucket.getnet.com.br/scm/sgm/module-core-ios.git", :tag => spec.version }

  spec.exclude_files = "Classes/Exclude"

  spec.license 		  = { :type => 'MIT', :file => "LICENSE" }

  spec.swift_version = "5"

  spec.dependency 'Alamofire'
  spec.dependency 'RxSwift'
  spec.dependency 'AppAuth'
  spec.dependency 'SwiftKeychainWrapper'
  spec.dependency 'JVFloatLabeledTextField'
  spec.dependency 'RxGesture'
  spec.dependency 'IQKeyboardManagerSwift'

  spec.source_files = ["#{spec.name}/**/*.{swift}", "#{spec.name}/**/*.{h}", "#{spec.name}/**/*.{m}"]

  spec.public_header_files = '*.h'

  spec.resources = ["#{spec.name}/**/*.{png}", "#{spec.name}/**/*.{jpeg}", "#{spec.name}/**/*. {jpg}",  "#{spec.name}/**/*.{pdf}", "#{spec.name}/**/*.{storyboard}", "#{spec.name}/**/*.{ttf}", "#{spec.name}/**/*.{xib}", "#{spec.name}/**/*.{json}", "#{spec.name}/**/*.{xcassets}", "#{spec.name}/**/*.{strings}"]

 
end
