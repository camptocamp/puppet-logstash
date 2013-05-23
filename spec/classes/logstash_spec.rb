require 'spec_helper'

describe 'logstash' do
  it { should include_class('logstash::install') }
  it { should include_class('logstash::config') }

  ['Debian', 'RedHat'].each do |osfamily|
    let(:facts) { {
      :osfamily       => osfamily,
      :concat_basedir => '/dir',
    } }
    
    it do
      should contain_package('logstash').with_ensure('present')
      should contain_user('logstash').with(
        'ensure' => 'present',
        'system' => true,
        'gid'    => 'logstash'
      )
      should contain_group('logstash').with(
        'ensure' => 'present',
        'system' => true
      )
    end
 
    [ '/usr/share/logstash',
      '/etc/logstash',
      '/var/log/logstash' ].each do |dir|

      context "should create directory #{dir} on #{osfamily}" do
        it do
          should contain_file(dir).with(
            'ensure' => 'directory',
            'owner'  => 'logstash',
            'group'  => 'logstash',
            'mode'   => '0755'
          )
        end
      end
    end
  end
end
