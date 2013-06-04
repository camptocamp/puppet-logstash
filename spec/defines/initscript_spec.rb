require 'spec_helper'

describe 'logstash::initscript' do
  let(:title) {'indexer'}

  let(:params) { {
    :ensure    => 'present',
    :java_opts => '-Xms256m -Xmx256m',
    :workers   => 1
  } }

  context 'on supported based systems' do

    ['Debian', 'RedHat'].each do |osfamily|
      let(:facts) { {
        :osfamily       => osfamily,
        :concat_basedir => '/dir',
      } }


      context "should create initscript logstash-indexer on #{osfamily}" do
        it do 
          should contain_file('/etc/init.d/logstash-indexer').with(
            'ensure' => 'present',                                                      
            'owner'  => 'root',                                                         
            'group'  => 'root',                                                         
            'mode'   => '0755'
          )
          content = catalogue.resource('file','/etc/init.d/logstash-indexer').send(:parameters)[:content]
          content.should_not be_empty
          content.should match('LS_HOME')
          content.should match('LS_USER')
          content.should match('LS_GROUP')
          content.should match('LS_CONF_FILE')
          content.should match('LS_LOG_FILE')
          content.should match('LS_PLUGINS_DIR')
          content.should match('LS_WORKERS')
          content.should match('JAVA_OPTS')
          content.should match('JAVA_ARGS')
          content.should match('PID_FILE')
        end
      end

      [ /PID_FILE=\/var\/run\/\$NAME\.pid/,
        /LS_HOME=\/usr\/share\/logstash/,
        /LS_USER=logstash/,
        /LS_GROUP=logstash/,
        /LS_CONF_FILE=\/etc\/logstash\/indexer\.conf/,
        /LS_LOG_FILE=\/var\/log\/logstash\/indexer\.log/,
        /LS_PLUGINS_DIR=\/usr\/share\/logstash\/plugins/,
        /LS_WORKERS="1"/,
        /JAVA_OPTS="-Xms256m -Xmx256m"/,
        /JAVA_ARGS="-jar \$\{LS_HOME\}\/logstash\.jar agent -f \$\{LS_CONF_FILE\} -w \$\{LS_WORKERS\} -l \$\{LS_LOG_FILE\} --pluginpath \$\{LS_PLUGINS_DIR\}"/].each do |arg|

        context "should contain arg #{arg} on #{osfamily}" do
          it { should contain_file('/etc/init.d/logstash-indexer').with_content(arg) }
        end
      end
    end
  end
end
