#
# Be sure to run `pod lib lint SHButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'SHButton'
s.version          = '0.1.1'
s.summary          = 'A simple custom button with animation.'
s.homepage         = 'https://github.com/harushuu/SHButton'
s.screenshots      = 'https://github.com/harushuu/SHButton/raw/master/Screenshots.gif'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '@harushuu' => 'hunter4n@gmail.com' }
s.source           = { :git => 'https://github.com/harushuu/SHButton.git', :tag => '0.1.1' }
s.platform     = :ios, '8.0'
s.requires_arc = true
s.source_files = 'SHButton/*'
s.frameworks = 'UIKit'

end

