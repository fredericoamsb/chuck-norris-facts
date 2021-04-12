use_frameworks!
workspace 'ChuckNorrisFacts.xcworkspace'

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
  pod 'Moya/RxSwift'
  pod 'AlamofireNetworkActivityLogger'
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

target 'Facts' do
  project 'Facts/Facts'
  rx_pods
  target 'FactsTests' do
    rx_tests
  end
end

target 'Domain' do
  project 'Domain/Domain'
  rx_pods
  target 'DomainTests'
end

target 'Networking' do
  project 'Networking/Networking'
  networkingPods
  target 'NetworkingTests'
end
