#
# Be sure to run `pod lib lint RBSOdometer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RBSOdometer'
  s.version          = '0.2.0'
  s.summary          = 'RBSOdometer is a ObjC library for smoothly transitioning numbers..'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                        DESC

  s.homepage         = 'https://github.com/RbBtSn0w/RBSOdometer'
  #s.screenshots      = 'https://github.com/RbBtSn0w/RBSOdometer/blob/master/RBSOdometerDemo.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RbBtSn0w' => 'hamiltonsnow@gmail.com' }
  s.source           = { :git => 'https://github.com/RbBtSn0w/RBSOdometer.git', :tag => s.version }
  s.requires_arc     = true
  s.social_media_url = 'https://twitter.com/RbBtSn0w'

  s.ios.deployment_target = '7.0'
  #s.watchos.deployment_target = '2.0'
  #s.tvos.deployment_target = '9.0'

  s.source_files = 'RBSOdometer/Classes/*.{h,m}'
  
  # s.resource_bundles = {
  #   'RBSOdometer' => ['RBSOdometer/Assets/*.png']
  # }

  #s.public_header_files = 'Pod/Classes/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'RBSReuseQueue', '~> 0.1.0'
end
