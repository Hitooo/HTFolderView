Pod::Spec.new do |s|

  s.name         = "HTFolderView"
  s.version      = "0.0.1"
  s.summary      = "a iOS folder style!"

  s.description  = "风格仿照iOS系统原生文件夹，支持明暗两种模式，支持滑动翻页!"

  s.homepage     = "https://github.com/Hitooo/HTFolderView"
  s.license      = 'MIT'
  s.author             = { "hitoo" => "1027825409@qq.com" }

  s.source       = { :git => "https://github.com/Hitooo/HTFolderView.git", :tag => "#{s.version}" }
  s.platform =  :ios, '7.0'
  s.source_files  = "HTFolderView/**/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
