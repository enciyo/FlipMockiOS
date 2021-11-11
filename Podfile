swift_version = "4.1"
flipperkit_version = '0.88.0'
use_frameworks!


def flipper_develop_pods
  pod 'FlipperKit', '~>' + '0.111.0',  :modular_headers => true
  # Layout and network plugins are not yet supported for swift projects
  pod 'FlipperKit/FlipperKitLayoutComponentKitSupport', '~>' + '0.111.0'
  pod 'FlipperKit/SKIOSNetworkPlugin', '~>' + '0.111.0'
  pod 'FlipperKit/FlipperKitUserDefaultsPlugin', '~>' + '0.111.0'

  # If you use `use_frameworks!` in your Podfile,
  # uncomment the below $static_framework array and also
  # the pre_install section.  This will cause Flipper and
  # it's dependencies to be static and all other pods to
  # be dynamic.
  $static_framework = ['FlipperKit', 'Flipper', 'Flipper-Folly',
    'CocoaAsyncSocket', 'ComponentKit', 'Flipper-DoubleConversion',
    'Flipper-Glog', 'Flipper-PeerTalk', 'Flipper-RSocket', 'Yoga', 'YogaKit',
    'CocoaLibEvent', 'OpenSSL-Universal', 'Flipper-Boost-iOSX', 'Flipper-Fmt']

  pre_install do |installer|
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
    installer.pod_targets.each do |pod|
        if $static_framework.include?(pod.name)
          def pod.build_type;
            Pod::BuildType.static_library
          end
        end
      end
  end
end


target 'FlipperMockPlugin' do
  platform :ios, '10.0'
  flipper_develop_pods

end



