#
# Be sure to run `pod lib lint StaticLabelManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StaticLabelManager"
  s.version          = "0.0.1"
  s.summary          = "A simple library to manage your application labels remotely"
  s.description      = <<-DESC
                       A library which help you to update labels without submitting your application. 
                       Put your label file online, configure the library and the manager will do everything for you. 
                       DESC
  s.homepage         = "https://github.com/julianlecalvez/StaticLabelManager-iOS"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Julian Le Calvez" => "lecalvez@gmail.com" }
  s.source           = { :git => "https://github.com/julianlecalvez/StaticLabelManager-iOS.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/julianlecalvez'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'StaticLabelManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
