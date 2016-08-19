#
# Be sure to run `pod lib lint StringStylizer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ContentAlertController"
  s.version          = "0.3.0"
  s.summary          = "content customizable AlertController"

  s.description      = <<-DESC
  AlertController provides dedicated views. They are convinience but has little flexibility. ContentAlertController is more flexible that you can put a custom view on AlertController.
                       DESC

  s.homepage         = "https://github.com/kazuhiro4949/ContentAlertController"
  s.license          = 'MIT'
  s.author           = { "Kazuhiro Hayashi" => "k.hayashi.info@gmail.com" }
  s.source           = { :git => "https://github.com/kazuhiro4949/ContentAlertController.git", :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ContentAlertController/*.swift'

  s.resources = ['ContentAlertController/Assets/*.storyboard', 'ContentAlertController/Assets/*.xib']
end
