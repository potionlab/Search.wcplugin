require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/extensions/universal-darwin-18/2.3.0/json-2.1.0"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/json-2.1.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/webconsole-0.2.1/lib"
