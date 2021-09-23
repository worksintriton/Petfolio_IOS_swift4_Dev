# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Petfolio' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'SDWebImage'
  pod 'Toucan'
  pod 'NVActivityIndicatorView'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'FSCalendar'
  pod 'Cosmos', '~> 23.0'
  pod 'Alamofire', '~> 5.0'
  pod 'SNShadowSDK'
  pod 'iOSDropDown'
  pod 'JJFloatingActionButton'
  pod 'AASignatureView'
  pod 'IQKeyboardManagerSwift'
  pod 'CircleBar'
  pod 'ImageCropper'
  # Pods for Petfolio
  target 'PetfolioTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PetfolioUITests' do
    # Pods for testing
  end

  post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
  
end
