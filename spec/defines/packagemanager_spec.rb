require 'spec_helper'

describe 'httpproxy::packagemanager' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'proxy-pkg' }
      let(:facts) { facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat') }
      let(:pre_condition) { 'class { "httpproxy": url => "proxy.my.org", port => 80, user => "user", pass => "pass" }' }

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }

        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_httpproxy__package__apt('httpproxy-apt').with(:ensure => 'present') }
          it { is_expected.not_to contain_httpproxy__package__yum('httpproxy-yum') }
          it { is_expected.not_to contain_httpproxy__package__rpm('httpproxy-rpm') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_httpproxy__package__apt('httpproxy-apt') }
          it { is_expected.to contain_httpproxy__package__yum('httpproxy-yum').with(:ensure => 'present') }
          it { is_expected.to contain_httpproxy__package__rpm('httpproxy-rpm').with(:ensure => 'present') }
        end

        it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
      end

      context 'with purge_apt_conf = true' do
        let(:params) { {purge_apt_conf: true} }

        it { is_expected.to compile.with_all_deps }

        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_httpproxy__package__apt('httpproxy-apt').with(:ensure => 'present') }
          it { is_expected.not_to contain_httpproxy__package__yum('httpproxy-yum') }
          it { is_expected.not_to contain_httpproxy__package__rpm('httpproxy-rpm') }
          it { is_expected.to contain_class('httpproxy::package::purge_apt_conf') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_httpproxy__package__apt('httpproxy-apt') }
          it { is_expected.to contain_httpproxy__package__yum('httpproxy-yum').with(:ensure => 'present') }
          it { is_expected.to contain_httpproxy__package__rpm('httpproxy-rpm').with(:ensure => 'present') }
          it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
        end
      end

      context 'with ensure = absent' do
        let(:params) { {ensure: 'absent'} }

        it { is_expected.to compile.with_all_deps }

        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_httpproxy__package__apt('httpproxy-apt').with(:ensure => 'absent') }
          it { is_expected.not_to contain_httpproxy__package__yum('httpproxy-yum') }
          it { is_expected.not_to contain_httpproxy__package__rpm('httpproxy-rpm') }
        elsif facts[:osfamily] == 'RedHat'
          it { is_expected.not_to contain_httpproxy__package__apt('httpproxy-apt') }
          it { is_expected.to contain_httpproxy__package__yum('httpproxy-yum').with(:ensure => 'absent') }
          it { is_expected.to contain_httpproxy__package__rpm('httpproxy-rpm').with(:ensure => 'absent') }
        end

        it { is_expected.not_to contain_class('httpproxy::package::purge_apt_conf') }
      end
    end
  end
end
