Pod::Spec.new do |spec|
  spec.name          = 'FIBPaymentSDK'
  spec.version       = '1.2.2'
  spec.platform     = :ios, "12.0"
  spec.license       = { :type => 'MIT' }
  spec.homepage      = 'https://github.com/First-Iraqi-Bank/fib-ios-sdk'
  spec.authors       = { 'Bako Abdullah' => 'bako.a@the-gw.com' }
  spec.summary       = 'FIBPaymentSDK is a framework which you can use to do you transaction using the First Iraqi Bank applications'
  spec.source = { :git => 'https://github.com/First-Iraqi-Bank/fib-ios-sdk.git', :tag=>spec.version }
  spec.vendored_frameworks = 'FIBPaymentSDK.xcframework'
  spec.swift_version = '5.0'

end
