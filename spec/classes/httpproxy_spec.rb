require 'spec_helper'

describe 'httpproxy', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat')
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'no port' do
        let(:params) do
          {
            http_proxy: 'http://proxy.test.com',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to }
      end

      context 'with all deactivated' do
        let(:params) do
          {
            http_proxy: 'http://proxy.test.com',
            http_proxy_port: 80,
          }
        end

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
