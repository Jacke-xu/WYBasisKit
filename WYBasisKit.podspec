Pod::Spec.new do |s|

  s.name         = "WYBasisKit"
  s.version      = "0.0.1"
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.summary      = "WYBasisKit是一款旨在提高开发者开发效率的Kit"
  s.description  = "WYBasisKit里面汇集了常用UI库的类扩展、方法扩展及网络JSON数
据解析、网络判断等方法封装，调用简单，帮助开发者提高开发效率。"
  s.homepage     = "https://github.com/Jacke-xu/WYBasisKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "jacke-xu" => "xuwangyong@aliyun.com" }
  s.source       = { :git => "https://github.com/Jacke-xu/WYBasisKit.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
