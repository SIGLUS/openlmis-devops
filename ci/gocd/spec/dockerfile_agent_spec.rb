# spec/dockerfile_agent_spec.rb

require 'serverspec'
require 'docker-api'
require 'json'

describe 'Dockerfile.agent' do
  before(:all) do
    @image = Docker::Image.build_from_dir('.', {'dockerfile' => 'Dockerfile.agent'}) do |v|
      if ( log = JSON.parse(v) ) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end
    @image.tag('repo' => 'gocd_agent', 'tag' => 'latest')
    set :backend, :docker
    set :os, family: :debian
    set :docker_image, @image.id
  end

  describe 'Dependencies' do
    context 'about jdk' do
      it 'has installed openjdk-1.7' do
        package_notifier = package('openjdk-7-jdk')
        expect(package_notifier.installed?).to be_truthy
      end
    end
  end
end
