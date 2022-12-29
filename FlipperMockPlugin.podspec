folly_compiler_flags = '-DDEBUG=1 -DFLIPPER_OSS=1 -DFB_SONARKIT_ENABLED=1 -DFOLLY_HAVE_BACKTRACE=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_HAVE_LIBGFLAGS=0 -DFOLLY_HAVE_LIBJEMALLOC=0 -DFOLLY_HAVE_PREADV=0 -DFOLLY_HAVE_PWRITEV=0 -DFOLLY_HAVE_TFO=0 -DFOLLY_USE_SYMBOLIZER=0'
header_search_paths = "\"$(PODS_ROOT)/Flipper-Boost-iOSX\" \"$(PODS_ROOT)/Flipper-DoubleConversion\" \"$(PODS_ROOT)/libevent/include\""
Pod::Spec.new do |spec|
  #Descriptions
  spec.name         = "FlipperMockPlugin"
  spec.version      = "1.0.2"
  spec.summary      = "Flipper Mock"
  spec.module_name = 'FlipperMockPlugin'
  spec.homepage     = "https://github.com/enciyo/"
  spec.license      = { :type => "MIT" }
  spec.author       = { "enciyo" => "enciyomk61@gmail.com" }
  #Configs

  #Platfrom
  spec.platforms = { :ios => '10.0'}  

  
  #Source
  spec.source   = { :git => 'file:///Users/mustafa.kilic/Desktop/flipper-mock-ios/FlipperMockPlugin', :tag => "master" }
  spec.source_files = '**/*.swift'
  
  spec.static_framework = true
  spec.dependency  'YogaKit'
  spec.dependency  'Yoga'
  spec.dependency 'Alamofire', '4.9.1'
  spec.dependency 'FlipperKit/Core'
  spec.compiler_flags = folly_compiler_flags
  spec.pod_target_xcconfig = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)\"/Headers/Private/FlipperKit/**" }

end
