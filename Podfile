# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'autoService' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for autoService
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'FirebaseFirestore'
pod 'FirebaseStorage'
pod 'Firebase'
pod 'FirebaseDatabase'
pod 'YandexMapsMobile', '4.4.0-lite'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

end
