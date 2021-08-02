Pod::Spec.new do |s|
  s.name             = 'RxMasMagicPills'
  s.version          = '2.0.0'
  s.swift_version    = '5.0'
  s.summary          = 'Set of powerful utilities based on Rx 💊.'

  s.description      = <<-DESC
Set of powerful utilities for development based on Rx in Swift (Support for iOS, tvOS and mac)
DESC

  s.homepage         = 'https://github.com/masmovil/swift-mas-magic-pills-rx'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.authors          = { 'MásMóvil' => 'info@grupomasmovil.com' }
  s.source           = { :git => 'https://github.com/masmovil/swift-mas-magic-pills-rx.git', :tag => "v#{s.version.to_s}" }
  s.social_media_url = 'https://twitter.com/masmovil'

  s.frameworks = 'Foundation'
  s.dependency('RxSwift', '~> 5')
  s.dependency('MasMagicPills')

  s.ios.deployment_target = '11.0'
  s.ios.frameworks = 'UIKit'
  s.ios.dependency('RxCocoa', '~> 5')
  s.ios.source_files = 'Sources/Protocols/**/*.swift', 'Sources/RxSwift/**/*.swift', 'Sources/UIKit/**/*.swift'

  s.osx.deployment_target = '10.13'
  s.osx.frameworks = 'AppKit'
  s.osx.source_files = 'Sources/Protocols/**/*.swift', 'Sources/RxSwift/**/*.swift'

  s.watchos.deployment_target = '4.0'
  s.watchos.frameworks = 'UIKit', 'WatchKit'
  s.watchos.source_files = 'Sources/Protocols/**/*.swift', 'Sources/RxSwift/**/*.swift'
  
  s.tvos.deployment_target = '11.0'
  s.tvos.frameworks = 'UIKit'
  s.tvos.source_files = 'Sources/Protocols/**/*.swift', 'Sources/RxSwift/**/*.swift'
end
