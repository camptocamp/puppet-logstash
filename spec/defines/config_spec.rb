require 'spec_helper'

describe 'logstash::config' do
  let(:title) {'allinputs'}
  let(:params) {{'instance' => 'indexer', 'type' => 'input', 'content' => 'TEST CONTENT'}}
 
  let(:facts) { {
    :osfamily       => 'Debian',
  } }

  it do
    should contain_file('/etc/logstash/indexer.conf.d/01-input-01-allinputs.conf').with_ensure('present')
  end

end
