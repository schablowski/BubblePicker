#
# Be sure to run `pod lib lint BubblePicker-Objective-C' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BubblePicker-Objective-C'
  s.version          = '1.0.0'
  s.summary          = 'An easy-to-use picker view built on UIKitDynamics which can be used for content picking for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An easy-to-use picker view built on UIKitDynamics which can be used for content picking for iOS.
                       DESC


  s.homepage         = 'https://github.com/schablowski/BubblePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stefan Schablowski' => 's.schablowski@web.de' }
  s.source           = { :git => 'https://github.com/schablowski/BubblePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = '*'
  
end
