require 'spec_helper'

describe 'logstash::instance' do
  let(:title) {'indexer'}
 
  let(:facts) { {
    :osfamily       => 'Debian',
    :concat_basedir => '/dir'
  } }

  it {should include_class('logstash::install')}
  it {should include_class('logstash::config')}
  it {should contain_service('logstash-indexer').with_ensure('running')}

  context 'with a custom java opts value' do
   let(:params){{:java_opts => '-Xms256m -Xmx256m'}}
   it do
    should contain_logstash__initscript('indexer')\
      .with_java_opts('-Xms256m -Xmx256m')
   end
  end

  context 'when passing default input/filter/output files' do
    let(:params) { {
      :ensure      => 'present',
      :input_file  => 'puppet:///modules/logstash/indexer-default-input',
      :filter_file => 'puppet:///modules/logstash/indexer-default-filter',
      :output_file => 'puppet:///modules/logstash/indexer-default-output',
    } }
  
    it do
      should contain_concat__fragment('input-indexer').with(
        :ensure => 'present',
        :target => '/etc/logstash/indexer.conf',
        :source => 'puppet:///modules/logstash/indexer-default-input',
        :order  => '01'
      )
      should contain_concat__fragment('filter-indexer').with(
        :ensure => 'present',
        :target => '/etc/logstash/indexer.conf',
        :source => 'puppet:///modules/logstash/indexer-default-filter',
        :order  => '02'
      )
      should contain_concat__fragment('output-indexer').with(
        :ensure  => 'present',
        :target  => '/etc/logstash/indexer.conf',
        :source  => 'puppet:///modules/logstash/indexer-default-output',
        :order   => '03'
      )
    end
  end
end
