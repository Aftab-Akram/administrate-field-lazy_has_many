lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'administrate/field/lazy_has_many/version'

Gem::Specification.new do |spec|
  spec.name          = 'administrate-field-lazy_has_many'
  spec.version       = Administrate::Field::LazyHasManyVersion::VERSION
  spec.authors       = ['Aftab Akram']
  spec.email         = ['aftabakram04@gmail.com']

  spec.summary       = 'A has many to-like field that lazily loads candidates from a custom endpoint.'
  spec.homepage      = 'https://github.com/Aftab-Akram/administrate-field-lazy_has_many'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'administrate', '>= 0.11.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake', '>= 12.3.3'
end
