#
# Be sure to run `pod lib lint ReactiveSwiftCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReactiveSwiftCell'
  s.version          = '0.1.0'
  s.summary          = 'Events from TableViewCells whitout reload TableView'

  s.homepage         = 'https://github.com/xander-lis/ReactiveSwiftCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksandr Lis' => 'xandr.lisss@gmail.com' }
  s.source           = { :git => 'https://github.com/xander-lis/ReactiveSwiftCell.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = "4.2"

  s.source_files = 'ReactiveSwiftCell/Classes/**/*'
  s.dependency 'ReactiveSwift', '~> 5.0'
  s.dependency 'ErrorDispatcher/ReactiveSwift', '~> 0.1.5'
end
