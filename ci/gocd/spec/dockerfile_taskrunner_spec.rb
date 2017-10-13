# spec/dockerfile_taskrunner_spec.rb

require 'serverspec'
require 'docker-api'
require 'json'

describe 'Dockerfile.taskrunner' do
  before(:all) do
    @image = Docker::Image.build_from_dir('.', {'dockerfile' => 'Dockerfile.taskrunner'}) do |v|
      if ( log = JSON.parse(v) ) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end
    @image.tag('repo' => 'gocd_taskrunner', 'tag' => 'latest')
    set :backend, :docker
    set :os, family: :debian
    set :docker_image, @image.id
  end

  describe 'Dependencies' do
    it 'has installed openjdk-1.7' do
      package_notifier = package('openjdk-7-jdk')
      expect(package_notifier.installed?).to be_truthy
    end

    it 'has installed nodejs' do
      package_notifier = package('nodejs')
      expect(package_notifier.installed?).to be_truthy
    end

    it 'has installed postgresql-client-9.4' do
      package_notifier = package('postgresql-client-9.4')
      expect(package_notifier.installed?).to be_truthy
    end

    it 'has installed zip' do
      package_notifier = package('zip')
      expect(package_notifier.installed?).to be_truthy
    end

    it 'has installed ansible' do
      package_notifier = package('ansible')
      expect(package_notifier.installed?).to be_truthy
    end
  end
end
