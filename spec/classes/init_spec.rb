require 'spec_helper'

describe 'httpproxy', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat')
      end

      context 'no url' do
        it { is_expected.to compile.and_raise_error(/Error while evaluating a Function Call/) }
      end

      context 'no port or creds' do
        let(:params) do
          {
            url: 'proxy.test.com',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_notify('proxy-uri')
          .with(
            :message => 'Proxy is http://proxy.test.com',
          )
        }
      end

      context 'no creds' do
        let(:params) do
          {
            url: 'proxy.test.com',
            port: 80,
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_notify('proxy-uri')
          .with(
            :message => 'Proxy is http://proxy.test.com:80',
          )
        }
      end

      context 'all set' do
        let(:params) do
          {
            url: 'proxy.test.com',
            port: 80,
            user: 'p_user',
            pass: 'p_pass',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_notify('proxy-uri')
          .with(
            :message => 'Proxy is http://p_user:p_pass@proxy.test.com:80',
          )
        }
      end
    end
  end
end
