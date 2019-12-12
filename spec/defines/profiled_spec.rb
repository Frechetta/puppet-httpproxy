require 'spec_helper'

describe 'httpproxy::profiled' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'proxy-profiled' }
      let(:facts) { facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat') }

      context 'with defaults' do
        let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass" }' }

        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_profiled__script('httpproxy.sh')
            .with(ensure: 'present')
            .with_content(%r{^export http_proxy=http:\/\/user:pass@proxy.my.org:80$})
            .with_content(%r{^export https_proxy=http:\/\/user:pass@proxy.my.org:80$})
        }
      end

      context 'with no_proxy' do
        let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass", no_proxy => ".my.org" }' }

        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_profiled__script('httpproxy.sh')
            .with(ensure: 'present')
            .with_content(%r{^export http_proxy=http://user:pass@proxy.my.org:80$})
            .with_content(%r{^export https_proxy=http://user:pass@proxy.my.org:80$})
            .with_content(%r{^export no_proxy=\.my\.org$})
        }
      end

      context 'with ensure = absent' do
        let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass" }' }
        let(:params) { { ensure: 'absent' } }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_profiled__script('httpproxy.sh').with(ensure: 'absent') }
      end
    end
  end
end
