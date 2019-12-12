require 'spec_helper'

describe 'httpproxy::wget' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'proxy-wget' }
      let(:facts) { facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat') }
      let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass" }' }

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_ini_setting('wget-http_proxy')
            .with(
              ensure: 'present',
              setting: 'http_proxy',
              value: 'http://user:pass@proxy.my.org:80',
            )
        }

        it {
          is_expected.to contain_ini_setting('wget-https_proxy')
            .with(
              ensure: 'present',
              setting: 'https_proxy',
              value: 'http://user:pass@proxy.my.org:80',
            )
        }
      end

      context 'with ensure = absent' do
        let(:params) { { ensure: 'absent' } }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_ini_setting('wget-http_proxy').with(ensure: 'absent') }
        it { is_expected.to contain_ini_setting('wget-https_proxy').with(ensure: 'absent') }
      end
    end
  end
end
