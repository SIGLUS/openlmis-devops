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
    context 'about Docker' do

      it 'has docker group' do
        response = group('docker')
        expect(response.exists?).to be_truthy
      end

      describe user('go') do
          it { should belong_to_group 'docker'  }
      end

      it 'has installed docker client only from go user session' do
        response = command('su -c "/usr/bin/docker --version" go')
        expect(response.stdout).to match 'Docker version 17.03.0-ce'
      end
    end
  end
end
