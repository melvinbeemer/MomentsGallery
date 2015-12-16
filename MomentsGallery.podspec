#
# Be sure to run `pod lib lint MomentsGallery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MomentsGallery"
  s.version          = "0.1.0"
  s.summary          = "A gallery view controller inspired by Twitter's Moments."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
MomentsGallery is a gallery view controller inspired by Twitter's Moments. It includes a parallax effect while swiping between photos, tap to view the full photo and the ability to add a title and a caption.
                       DESC

  s.homepage         = "https://github.com/Fortyfox/MomentsGallery"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Melvin Beemer" => "melvin.beemer@gmail.com" }
  s.source           = { :git => "https://github.com/Fortyfox/MomentsGallery.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/melvinbeemer'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MomentsGallery' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'HanekeSwift'
end
