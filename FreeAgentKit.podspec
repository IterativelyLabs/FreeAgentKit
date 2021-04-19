Pod::Spec.new do |s|
  s.name             = 'FreeAgentKit'
  s.version          = '0.3.0'
  s.summary          = 'A Swift client library for FreeAgent'
  s.description      = <<-DESC
  A Swift client implementation that facilitates access to FreeAgent data for an account user
                       DESC

  s.homepage         = 'https://github.com/IterativelyLabs/FreeAgentKit'
  s.license          = { :type => 'GNU GPL 3.0', :file => 'LICENSE' }
  s.author           = { 'IterativelyKarl' => 'karl@iteratively.co.uk' }
  s.source           = { :git => 'https://github.com/IterativelyLabs/FreeAgentKit.git', :tag => s.version.to_s }
  s.source_files = 'Sources/FreeAgentKit/**/*'
  s.swift_version = '5.3'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '11.0'
  s.dependency 'Alamofire', '~> 5.4.2'
end
