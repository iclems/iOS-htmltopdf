Pod::Spec.new do |s|
  s.name         = "iOS-htmltopdf"
  s.version      = "0.0.2"
  s.summary      = "This class enables simple URL-based PDF creation."
  s.description  = "Pages are created the exact same way they would be if the user printed the content on an iOS device (very similar as well as OS X print output)."
  s.homepage     = "https://github.com/iclems/iOS-htmltopdf"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Clément Wehrung" => "cwehrung@nurves.com" }
  s.source       = { :git => "https://github.com/martinjuhasz/iOS-htmltopdf.git", :commit => "8f7b94129f4b08349b3d5521bb3c3047c9f381cc" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', '**/*.{h,m}'
  s.exclude_files = 'HTMLtoPDF-Demo'
  s.requires_arc = true
end
