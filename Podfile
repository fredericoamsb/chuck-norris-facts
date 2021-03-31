workspace 'ChuckNorrisFacts.xcworkspace'

# version
platform :ios, '9.0'

# defs

def rx_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

def rx_tests
  pod 'RxTest'
  pod 'RxBlocking'
end

def tools
  pod 'SwiftGen'
  pod 'SwiftLint'
end

def networkingPods
  pod 'RxAlamofire'
end

def diPods
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
end

# targes

target 'App' do
  project 'App/App'
  rx_pods
  tools
  networkingPods
  diPods
  target 'AppTests' do
    inherit! :search_paths
  end
end

target 'DI' do
  project 'DI/DI'
  diPods
  target 'DITests' do
    inherit! :search_paths
  end
end

target 'Facts' do
  project 'Facts/Facts'
  rx_pods
  target 'FactsTests' do
    inherit! :search_paths
    rx_tests
  end
end

target 'Networking' do
  project 'Networking/Networking'
  networkingPods
  target 'NetworkingTests' do
    inherit! :search_paths
  end
end
