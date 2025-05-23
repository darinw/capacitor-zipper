
  Pod::Spec.new do |s|
    s.name = 'CapacitorZipper'
    s.version = '7.0.0'
    s.summary = 'Zip plugin'
    s.license = 'MIT'
    s.homepage = 'https://github.com/darinw/capacitor-zipper'
    s.author = 'Darin Wolyniec'
    s.source = { :git => 'https://github.com/darinw/capacitor-zipper', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '10.0'
    s.dependency 'Capacitor'
    s.dependency 'SSZipArchive'
  end
