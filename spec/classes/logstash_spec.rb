require 'spec_helper'

describe 'logstash' do
  it { should contain_class('logstash::install') }

  ['Debian', 'RedHat'].each do |osfamily|
    let(:facts) { {
      :osfamily       => osfamily,
    } }
    
    it do
      should contain_package('logstash').with_ensure('present')
      should contain_file('/var/lib/logstash/logstash/inputs').with_ensure('directory')
      should contain_file('/var/lib/logstash/logstash/filters').with_ensure('directory')
      should contain_file('/var/lib/logstash/logstash/outputs').with_ensure('directory')
    end
 
  end
end
