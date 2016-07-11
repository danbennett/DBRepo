Pod::Spec.new do |spec|

  spec.name = "DBRepo"
  spec.version = "0.0.1"
  spec.summary = "A library for creating repositories to manage model objects."

  spec.homepage = "https://github.com/danbennett/DBRepo.git"

  spec.author = { "Dan Bennett" => "hellodanb@gmail.com" }

  spec.ios.deployment_target = "8.0"
  spec.license = "MIT"

  spec.source  = { :git => "https://github.com/danbennett/DBRepo.git", :tag => "0.0.1" }

  spec.default_subspec = 'Common'

  spec.subspec "Common" do |sp|
    sp.source_files  = "DBRepo/Repo/*.{swift}", "DBRepo/Repo/Global/*.{swift}"
  end

  spec.subspec "CoreData" do |sp|
    sp.source_files = "DBRepo/Repo/CoreData/*.{swift}"
    sp.dependency 'DBRepo/Common'
    sp.ios.deployment_target = "8.0"

    sp.subspec "Setup" do |sp|
      sp.source_files = "DBRepo/Repo/CoreData/Setup/*.{swift}"
      sp.dependency 'DBRepo/Common/CoreData'
      sp.ios.deployment_target = "8.0"
    end

  end

  spec.requires_arc = true

end
