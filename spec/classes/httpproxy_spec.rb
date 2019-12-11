require 'spec_helper'

describe 'httpproxy' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat')
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'with all activated' do
        let(:params) do
          {
            http_proxy: 'proxy.test.com',
            http_proxy_port: 80,
          }
        end

        it { is_expected.to compile.with_all_deps }
      end

      context 'with all deactivated' do
        let(:params) do
          {
            http_proxy: 'proxy.test.com',
            http_proxy_port: 80,
          }
        end

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
