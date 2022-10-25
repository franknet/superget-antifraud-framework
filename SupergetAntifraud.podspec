
Pod::Spec.new do |spec|
  spec.name         = "SupergetAntifraud"
  spec.version      = "1.0.0"
  spec.summary      = "Superget Antifraund Framework." 
  spec.description  = "Módulo Antifraude do App Superget"

  spec.homepage     = "http://getnet.com.br"
  spec.license      = "MIT Superget"
  spec.author       = { "José Franklin" => "franklinsilvaalves@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://bitbucket.getnet.com.br/scm/sgm/module-core-ios.git", :tag => spec.version }
  spec.source_files  = "SupergetAntifraud/**/*" 
  spec.swift_version = "5.0"

  spec.dependency "STAIdentify"

end
