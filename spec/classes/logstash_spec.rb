require 'spec_helper'

describe 'logstash' do
  it { should contain_class('logstash::install') }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it do
        should contain_package('logstash').with_ensure('present')
        should contain_file('/var/lib/logstash/logstash/inputs').with_ensure('directory')
        should contain_file('/var/lib/logstash/logstash/filters').with_ensure('directory')
        should contain_file('/var/lib/logstash/logstash/outputs').with_ensure('directory')
      end
    end
  end
end
