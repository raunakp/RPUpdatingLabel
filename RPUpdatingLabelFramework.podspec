Pod::Spec.new do |s|
  s.name         = "RPUpdatingLabelFramework"
  s.version      = "1.11"
  s.module_name  = "RPUpdatingLabel"
  s.summary      = "Auto updating label showing elapsed time"
  s.description  = <<-DESC
                   RPUpdatingLabel is an iOS Swift library with UILabel subclass that auto updates with elapsed time.
                   DESC
  s.homepage     = "https://github.com/raunakp/RPUpdatingLabel"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = { 'Raunak Poddar' => 'raunak.poddar@gmail.com' }

  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/raunakp/RPUpdatingLabel.git", :tag => "#{s.version}" }
  s.source_files = "RPUpdatingLabel/*.{swift,m,h}"
  s.public_header_files = "RPUpdatingLabel/*.{h}"
  s.swift_version = '5.0'
end
