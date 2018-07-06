# Uncomment this line to define a global platform for your project
platform :ios, '11.3'

target 'PrimaMateria' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    #pod 'CorePlot', '~> 2.2'
    pod 'CorePlot', :git => 'https://github.com/core-plot/core-plot.git', :branch => 'release-2.3'

    pod 'RxSwift'
    #pod 'RxCocoa'
    #pod 'RxSwiftExt'
    #pod 'RxDataSources'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.1'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '11.3'
        end
    end
end
