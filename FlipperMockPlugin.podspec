Pod::Spec.new do |spec|

  spec.name         = "FNetworkPlugin"
  spec.version      = "0.0.1"
  spec.summary      = "Flipper Mock"

  spec.description  = <<-DESC
  Fliiper Mock.
                   DESC

  spec.homepage     = "https://github.com/jeantimex/SwiftyLib"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "enciyo" => "enciyomk61@gmail.com" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/jeantimex/SwiftyLib.git", :tag => "#{spec.version}" }
  spec.source_files  = "FNetworkPlugin/**/*.{h,m,swift}"

end