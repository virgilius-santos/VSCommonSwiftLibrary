source 'https://github.com/virgilius-santos/public-pod-specs.git'
source 'https://cdn.cocoapods.org/'

platform :ios, '12.4'

use_frameworks!

def quickTests
  pod 'Quick'                 , '~> 3.1', :inhibit_warnings => true
  pod 'Nimble'                , '~> 9.0', :inhibit_warnings => true
end

workspace 'VSCommonSwiftLibrary'
project 'VCore/VCore.xcodeproj'
project 'VService/VService.xcodeproj'
  
target 'VCore' do
  project 'VCore/VCore.xcodeproj'

  pod 'Willow'      , '~> 5.2', :inhibit_warnings => true
  
  target 'VCoreTests' do 
    quickTests
  end
end

target 'VService' do
  project 'VService/VService.xcodeproj'

  pod "VCore"                   , '~> 0.3'#, :path => '../'
  pod 'Kingfisher'              , '~> 6.2', :inhibit_warnings => true

  target 'VServiceTests' do
    quickTests

    pod 'OHHTTPStubs/Swift'     , '~> 9.1', :inhibit_warnings => true
  end
end