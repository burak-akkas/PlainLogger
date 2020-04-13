Pod::Spec.new do |s|
  s.name             = 'PlainLogger'
  s.version          = '0.1.0'
  s.summary          = 'Plain and easy to use logger.'

  s.description      = <<-DESC
    Plain and easy to use logger with styling and templating options.
                       DESC

  s.homepage         = 'https://github.com/burak-akkas/PlainLogger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Burak Akkaş' => 'burak.akkas@outlook.com' }
  s.source           = { :git => 'https://github.com/burak-akkas/PlainLogger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'PlainLogger/Classes/**/*'
end
