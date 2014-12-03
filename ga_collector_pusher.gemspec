# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ga_collector_pusher/version"

Gem::Specification.new do |s|
  s.name = "ga_collector_pusher"
  s.version = GACollectorPusher::VERSION
  s.author = "Girts Kesteris"
  s.email = ["girts.kesteris@gmail.com"]
  s.homepage = "https://github.com/Sacristan/ga_collector_pusher.git"
  s.platform = Gem::Platform::RUBY
  s.summary = "Push data to GoogleAnalytics via Ruby Backend "
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.rdoc"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rubyforge_project = "ga_collector_pusher"

  s.add_development_dependency 'rake'
  s.add_development_dependency "rspec"

  s.add_dependency "rest-client"
end
