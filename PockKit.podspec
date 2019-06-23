#
# Be sure to run `pod lib lint PockKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PockKit'
  s.version          = '0.1.1'
  s.summary          = 'Core framework for building Pock widgets.'

  s.description      = <<-DESC
PockKit is the core framework for building Pock widgets.
Documentation can be found at https://kit.pock.dev/docs/
                       DESC

  s.homepage         = 'https://kit.pock.dev'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pock' => 'hello@pock.dev' }
  s.source           = { :git => 'http://git.pigigaldi.com:8383/Pock/PockKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_pockapp'

  s.platform = :osx
  s.osx.deployment_target = "10.12.2"
  s.swift_version = "5.0"
  
  s.frameworks = 'Foundation'
  s.frameworks = 'AppKit'
  
  s.exclude_files = ['docs/**/*']
  
  s.subspec 'Protocols' do |ss|
    ss.source_files = 'PockKit/Protocols/**/*'
  end
  
  s.subspec 'Sources' do |ss|
    ss.source_files = 'PockKit/Sources/**/*'
  end
  
  s.dependency 'SnapKit'

end
