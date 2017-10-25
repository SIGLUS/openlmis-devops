# spec/dockerfile_agent_spec.rb

require 'serverspec'
require 'docker-api'
require 'json'

describe 'Dockerfile.mobile.agent' do
  before(:all) do
    @image = Docker::Image.build_from_dir('.', {'dockerfile' => 'Dockerfile.mobile.agent'}) do |v|
      if ( log = JSON.parse(v) ) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end
    @image.tag('repo' => 'gocd_mobile_agent', 'tag' => 'latest')
    set :backend, :docker
    set :os, family: :debian
    set :docker_image, @image.id
  end

  describe 'Dependencies' do
    context 'about Docker' do
      it 'has installed docker-compose' do
        response = command('su -c "/usr/local/bin/docker-compose --version" go')
        expect(response.stdout).to match 'docker-compose version 1.16.1'
      end
    end

    describe package('ruby') do
      it { should be_installed }
    end

    describe package('awscli') do
      it { should be_installed.by('pip') }
    end
  end
end
