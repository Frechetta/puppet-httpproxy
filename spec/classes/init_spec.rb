require 'spec_helper'

describe 'httpproxy', type: 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(environment => 'test', :concat_basedir => '/var/lib/puppet/concat') }

      context 'no url' do
        it { is_expected.to compile.and_raise_error(%r{Error while evaluating a Function Call}) }
      end

      context 'no port or creds' do
        let(:params) { { url: 'proxy.test.com' } }

        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_file('/tmp/.proxy')
            .with(ensure: 'present')
            .with_content(%r{^http://proxy.test.com$})
        }
      end

      context 'no creds' do
        let(:params) { { url: 'proxy.test.com', port: 80 } }

        it { is_expected.to compile.with_all_deps }

        it {
          is_expected.to contain_file('/tmp/.proxy')
            .with(ensure: 'present')
            .with_content(%r{^http://proxy.test.com:80$})
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

        it {
          is_expected.to contain_file('/tmp/.proxy')
            .with(ensure: 'present')
            .with_content(%r{^http://p_user:p_pass@proxy.test.com:80$})
        }
      end
    end
  end
end
