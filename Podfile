# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

workspace 'WeatherApp'

#newsapi module
def networkapi_pods
  pod 'Alamofire', '~> 5.5'
  pod 'AlamofireImage'
end

def application_pods
    networkapi_pods
end

#networkapi module
target 'NetworkAPI' do
    project 'WeatherApp/NetworkAPI/NetworkAPI.project'
    pod 'Alamofire', '~> 5.5'
    pod 'AlamofireImage'
end

#app module
target 'WeatherApp' do
  use_frameworks!
  # Pods for WeatherApp
  application_pods
end
