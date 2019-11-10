Pod::Spec.new do |s|
  s.name             = 'BloodyMary'
  s.version          = File.read(".version")
  s.summary          = 'A one directional MVVM framework.'
  s.homepage         = 'https://theinkedengineer.com'
  s.license          = { :type => 'Apache License 2.0' }
  s.author           = { 'Firas Safa' => 'firas@theinkedengineer.com' }
  s.source           = { :git => 'https://github.com/TheInkedEngineer/BloodyMary.git', :tag => s.version.to_s }

  s.swift_version    = '5.1'

  s.ios.deployment_target = '10.0'
  
  s.ios.source_files = [
    'BloodyMary/Core/**/*.swift',
    'BloodyMary/Resources/BloodyMary.h',
  ]

end
