#
# Be sure to run `pod lib lint YNDropDownMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YNExpandableCell'
  s.version          = '0.1.0'
  s.summary          = 'Easiest way to expand and collapse cell for iOS with Swift 3'

  s.description      = <<-DESC
                        Easiest usage of expandable&collapsable cell for iOS, written in Swift 3. You can customize expandable UITableViewCell whatever you like. 
                        DESC

  s.homepage         = 'https://github.com/younatics/YNExpandableCell'
  s.screenshots      = 'https://raw.githubusercontent.com/younatics/YNDropDownMenu/master/Images/YNDropDownMenu.gif', 'https://raw.githubusercontent.com/younatics/YNDropDownMenu/master/Images/YNDropDownMenu2.gif', 'https://raw.githubusercontent.com/younatics/YNDropDownMenu/master/Images/YNDropDownMenu3.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Seungyoun Yi" => "younatics@gmail.com" }

  s.source           = { :git => 'https://github.com/younatics/YNExpandableCell.git', :tag => s.version.to_s }
  s.source_files     = 'YNExpandableCell/YNExpandableCell/*.swift'

  s.ios.deployment_target = '8.0'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.requires_arc = true
end
