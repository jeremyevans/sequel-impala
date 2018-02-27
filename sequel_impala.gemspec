Gem::Specification.new do |s|
  s.name = 'sequel_impala'
  s.version = '1.1.0'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["LICENSE"]
  s.rdoc_options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'sequel_impala: Sequel support for Impala database', '--main', 'README.md']
  s.license = "MIT"
  s.summary = "Sequel support for Impala database"
  s.author = "Ryan Duryea"
  s.email = "aguynamedryan@gmail.com"
  s.homepage = "http://github.com/outcomesinsights/sequel_impala"
  s.files = %w(LICENSE CHANGELOG.md README.md Rakefile) + Dir["{spec,lib}/**/*.rb"] + Dir["lib/driver/*.jar"]
  s.description = <<END
sequel_impala adds an Impala shared adapter, impala adapter,
and jdbc/hive2 adapter for connecting to Impala.  It includes
modified versions of the impala and jdbc-hive2 gems that have
been updated, tested, and optimized.
END
  s.add_dependency('sequel', '~> 5.0')
  s.add_dependency('thrift', '~> 0.9')
  s.add_dependency('gssapi', '~> 1.2')
  s.add_development_dependency('rake', '> 0')
  s.add_development_dependency("minitest", '~> 5.7')
  s.add_development_dependency("minitest-hooks", '> 0')
  s.add_development_dependency("minitest-shared_description", '> 0')
  s.add_development_dependency("activesupport", '~> 4')
end
