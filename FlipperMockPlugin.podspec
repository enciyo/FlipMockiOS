folly_compiler_flags = '-DDEBUG=1 -DFLIPPER_OSS=1 -DFB_SONARKIT_ENABLED=1 -DFOLLY_HAVE_BACKTRACE=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_HAVE_LIBGFLAGS=0 -DFOLLY_HAVE_LIBJEMALLOC=0 -DFOLLY_HAVE_PREADV=0 -DFOLLY_HAVE_PWRITEV=0 -DFOLLY_HAVE_TFO=0 -DFOLLY_USE_SYMBOLIZER=0'
Pod::Spec.new do |spec|
  #Descriptions
  spec.name         = "FlipperNetworkMockPlugin"
  spec.version      = "0.0.1"
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
  

  spec.dependency  'FlipperKit/Core'
  spec.dependency  'YogaKit'
  spec.dependency  'Yoga'
  spec.dependency 'Alamofire'
  

end