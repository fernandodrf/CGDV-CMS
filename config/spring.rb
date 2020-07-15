%w(
  config/application.yml
).each { |path| Spring.watch(path) }