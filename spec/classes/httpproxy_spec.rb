require 'spec_helper'

describe 'httpproxy' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(environment => 'test', concat_basedir => '/var/lib/puppet/concat')
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('httpproxy::profiled') }
        it { is_expected.to contain_class('httpproxy::packagemanager') }
        if facts[:osfamily] == 'Debian' or facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
        elsif facts[:osfamily] == 'Debian'
          it { is_expected.to contain_class('httpproxy::package::apt') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.to contain_class('httpproxy::package::yum') }
          it { is_expected.to contain_class('httpproxy::package::rpm') }
        end
        it { is_expected.not_to contain_class('httpproxy::wget') }
        it { is_expected.not_to contain_class('httpproxy::gem') }
      end

      context 'with all activated' do
        let(:params) do
          {
            http_proxy      => 'proxy.test.com',
            http_proxy_port => 80,
            profiled        => true,
            packagemanager  => true,
            wget            => true,
            gem             => true,
            purge_apt_conf  => true,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('httpproxy::profiled') }
        it { is_expected.to contain_class('httpproxy::packagemanager') }
        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_class('httpproxy::package::apt') }
          it { is_expected.to contain_class('httpproxy::package::purge_apt_conf') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.to contain_class('httpproxy::package::yum') }
          it { is_expected.to contain_class('httpproxy::package::rpm') }
          it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
        end
        it { is_expected.to contain_class('httpproxy::wget') }
        it { is_expected.to contain_class('httpproxy::gem') }
      end

      context 'with all deactivated' do
        let(:params) do
          {
            http_proxy      => 'proxy.test.com',
            http_proxy_port => 80,
            profiled        => false,
            packagemanager  => false,
            wget            => false,
            gem             => false,
            purge_apt_conf  => false,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_class('httpproxy::profiled') }
        it { is_expected.not_to contain_class('httpproxy::packagemanager') }
        if facts[:osfamily] == 'Debian' or facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
        elsif facts[:osfamily] == 'Debian'
          it { is_expected.not_to contain_class('httpproxy::package::apt') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_class('httpproxy::package::yum') }
          it { is_expected.not_to contain_class('httpproxy::package::rpm') }
        end
        it { is_expected.not_to contain_class('httpproxy::wget') }
        it { is_expected.not_to contain_class('httpproxy::gem') }
      end
    end
  end
end
