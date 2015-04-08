require 'spec_helper'

describe 'logstash::instance' do
  let(:title) {'indexer'}

  let(:pre_condition) {
    'include ::logstash'
  }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it do
        should contain_service('logstash-indexer').with_ensure('running')
        should contain_file('/etc/init.d/logstash-indexer').with_ensure('present')
        case facts[:osfamily]
        when 'Debian'
          should contain_file('/etc/default/logstash-indexer').with_ensure('present')
        when 'RedHat'
          should contain_file('/etc/sysconfig/logstash-indexer').with_ensure('present')
        end
      end
    end
  end
end
