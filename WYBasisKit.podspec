Pod::Spec.new do |s|
  s.name         = "WYBasisKit"
  s.version      = "0.0.1"
  s.summary      = ""WYBasisKit" 不仅可以帮助开发者快速构建一个工程，还有基于常用网络框架和系统API而封装的方法，开发者只需简单的调用API就可以快速实现相应功能， 大幅提高开发效率。"
  s.description  = < "mobileAppDvlp@icloud.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Jacke-xu/WYBasisKit", :tag =>"0.0.1" }
  s.source_files  = "WYBasisKit", "WYBasisKit/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
