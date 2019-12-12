require 'spec_helper'

describe 'httpproxy::gem' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'proxy-gem' }
      let(:facts) { facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat') }
      let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass" }' }

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_file('/etc/gemrc')
            .with(ensure: 'present')
            .with_content(%r{^http_proxy: "http://user:pass@proxy.my.org:80"$})
        }
      end

      context 'with custom path' do
        let(:params) { { path: '/root/.gemrc' } }

        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_file('/root/.gemrc')
            .with(ensure: 'present')
            .with_content(%r{^http_proxy: "http://user:pass@proxy.my.org:80"$})
        }
      end

      context 'with ensure = absent' do
        let(:params) { { ensure: 'absent' } }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_file('/etc/gemrc').with(ensure: 'absent') }
      end
    end
  end
end
