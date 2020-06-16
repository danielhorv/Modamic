
Pod::Spec.new do |spec|
  spec.name        		  = "Modamic"
  spec.version      	  = ENV['LIB_VERSION']
  spec.summary		      = "A short description of Modamic."
  spec.description  	  = <<-DESC
  						  Lightweight, configurable modal presentation framework
                   		 DESC
  spec.homepage		      = "https://github.com/danielhorv/Modamic"
  spec.license     		  = "MIT"
  spec.author             = "Daniel Horvath"
  spec.social_media_url   = "https://twitter.com/picipuma"
  spec.platform     	  = :ios, "9.0"
  spec.source       	  = { :git => "https://github.com/danielhorv/Modamic.git", :tag => "#{spec.version}" }
  spec.swift_version 	  = '5.0'
  spec.source_files  	  = "Modamic/Source/**/*.swift"
end
