require 'spec_helper'

describe 'php_fpm' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "php_fpm class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('php_fpm::params') }
        it { should contain_class('php_fpm::install').that_comes_before('php_fpm::config') }
        it { should contain_class('php_fpm::config') }
        it { should contain_class('php_fpm::service').that_subscribes_to('php_fpm::config') }

        it { should contain_service('php_fpm') }
        it { should contain_package('php_fpm').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'php_fpm class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('php_fpm') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
