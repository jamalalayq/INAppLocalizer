#
# Be sure to run `pod lib lint INAppLocalizer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'INAppLocalizer'
  s.version          = '1.0.0'
  s.swift_version    = '5.0'
  s.summary          = 'Localizations in application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
INAppLocalizer swift library use it localize strings in applications.
                       DESC

  s.homepage         = 'https://github.com/gemgemo/INAppLocalizer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gamal' => 'gamalal3yk@gmail.com' }
  s.source           = { :git => 'https://github.com/gemgemo/INAppLocalizer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'INAppLocalizer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'INAppLocalizer' => ['INAppLocalizer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
