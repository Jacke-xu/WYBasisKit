Pod::Spec.new do |s|

  s.name         = "WYBasisKit"
  s.version      = "0.0.1"
  s.summary      = "WYBasisKit里面汇集了常用的类扩展，帮助开发者提高开发效率。"
  s.description  = "WYBasisKit里面汇集了常用UI库的类扩展、方法扩展及网络JSON数
据解析、网络判断等方法封装，调用简单，帮助开发者提高开发效率。"
  s.homepage     = "https://github.com/Jacke-xu/WYBasisKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "jacke-xu" => "xuwangyong@aliyun.com" }
  s.source       = { :git => "https://github.com/Jacke-xu/WYBasisKit.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
