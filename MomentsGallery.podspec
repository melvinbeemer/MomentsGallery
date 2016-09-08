Pod::Spec.new do |s|
  s.name             = "MomentsGallery"
  s.version          = "0.1.3"
  s.summary          = "A gallery view controller inspired by Twitter's Moments."

  s.description      = <<-DESC
MomentsGallery is a gallery view controller inspired by Twitter's Moments. It includes a parallax effect while swiping between photos, tap to view the full photo and the ability to add a title and a caption.
                       DESC

  s.homepage         = "https://github.com/Fortyfox/MomentsGallery"
  s.screenshot       = "https://i.imgur.com/F5DzQIw.gif"
  s.license          = 'MIT'
  s.author           = { "Melvin Beemer" => "melvin.beemer@gmail.com" }
  s.source           = { :git => "https://github.com/Fortyfox/MomentsGallery.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/melvinbeemer'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit'
  s.dependency 'HanekeSwift', '~> 0.10.0'
end
