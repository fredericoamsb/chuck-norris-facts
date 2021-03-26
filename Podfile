use_frameworks!
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
  target 'AppTests'
end

target 'DI' do
  project 'DI/DI'
  diPods
  target 'DITests'
end

target 'SearchChuckNorrisFacts' do
  project 'SearchChuckNorrisFacts/SearchChuckNorrisFacts'
  rx_pods
  target 'SearchChuckNorrisFactsTests'
end

target 'Networking' do
  project 'Networking/Networking'
  networkingPods
  target 'NetworkingTests'
end
