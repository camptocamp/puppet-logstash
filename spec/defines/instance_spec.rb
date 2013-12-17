require 'spec_helper'

describe 'logstash::instance' do
  let(:title) {'indexer'}
 
  let(:facts) { {
    :osfamily       => 'Debian',
  } }

  it do
    should contain_service('logstash-indexer').with_ensure('running')
    should contain_file('/etc/init.d/logstash-indexer').with_ensure('present')
    should contain_file('/etc/default/logstash-indexer').with_ensure('present')
  end

end
