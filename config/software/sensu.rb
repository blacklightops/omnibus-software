name "sensu"
version "0.12.6"

dependency "ruby"
dependency "rubygems"
dependency "libffi"
dependency "nokogiri"
dependency "ffi"
dependency "curl"
dependency "libnetsnmp"

env = {	"PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig" }

build do
  gem "install sensu -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
  gem "install sensu-cli -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install sensu-plugin -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install sensu-dashboard -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install bunny --no-rdoc --no-ri" , :env => env
  gem "install net-ssh --no-rdoc --no-ri" , :env => env
  gem "install net-sftp --no-rdoc --no-ri" , :env => env
  gem "install net-dhcp --no-rdoc --no-ri" , :env => env
  gem "install net-dns --no-rdoc --no-ri" , :env => env
  gem "install net-ip --no-rdoc --no-ri" , :env => env
  gem "install net-ldap --no-rdoc --no-ri" , :env => env
  gem "install net-ntp --no-rdoc --no-ri" , :env => env
  gem "install net-ping --no-rdoc --no-ri" , :env => env
  gem "install net-snmp --no-rdoc --no-ri" , :env => env
  gem "install nori --no-rdoc --no-ri" , :env => env
  gem "install carrot-top --no-rdoc --no-ri" , :env => env
  gem "install dnsbl-client --no-rdoc --no-ri" , :env => env
  gem "install lxc --no-rdoc --no-ri" , :env => env
  gem "install mail --no-rdoc --no-ri" , :env => env
  gem "install redis --no-rdoc --no-ri" , :env => env
  gem "install rest-client --no-rdoc --no-ri" , :env => env
  gem "install snmp --no-rdoc --no-ri" , :env => env
  gem "install curb --no-rdoc --no-ri" , :env => env
  gem "install mechanize --no-rdoc --no-ri" , :env => env
  gem "install addressable --no-rdoc --no-ri" , :env => env
  gem "install coffee-script --no-rdoc --no-ri" , :env => env
  gem "install coffee-script-source --no-rdoc --no-ri" , :env => env
  gem "install commonjs --no-rdoc --no-ri" , :env => env
  gem "install cookiejar --no-rdoc --no-ri" , :env => env
#  gem "install em-http-request --no-rdoc --no-ri" , :env => env
  gem "install em-socksify --no-rdoc --no-ri" , :env => env
  gem "install execjs --no-rdoc --no-ri" , :env => env
  gem "install handlebars_assets --no-rdoc --no-ri" , :env => env
  gem "install hike --no-rdoc --no-ri" , :env => env
#  gem "install http_parser.rb --no-rdoc --no-ri" , :env => env
  gem "install ipaddress --no-rdoc --no-ri" , :env => env
  gem "install less --no-rdoc --no-ri" , :env => env
#  gem "install libv8 --no-rdoc --no-ri" , :env => env
  gem "install mixlib-log --no-rdoc --no-ri" , :env => env
  gem "install mixlib-shellout --no-rdoc --no-ri" , :env => env
#  gem "install ohai --no-rdoc --no-ri" , :env => env
  gem "install psych --no-rdoc --no-ri" , :env => env
  gem "install ref --no-rdoc --no-ri" , :env => env
  gem "install sass --no-rdoc --no-ri" , :env => env
  gem "install slim --no-rdoc --no-ri" , :env => env
  gem "install sprockets --no-rdoc --no-ri" , :env => env
  gem "install systemu --no-rdoc --no-ri" , :env => env
  gem "install temple --no-rdoc --no-ri" , :env => env
#  gem "install test-unit --no-rdoc --no-ri" , :env => env
#  gem "install therubyracer --no-rdoc --no-ri" , :env => env
  gem "install yajl-ruby --no-rdoc --no-ri" , :env => env
  gem "install yui-compressor --no-rdoc --no-ri" , :env => env

  # remove documentation
  command "rm -rf #{install_dir}/embedded/docs"
  command "rm -rf #{install_dir}/embedded/share/man"
  command "rm -rf #{install_dir}/embedded/man"
  command "rm -rf #{install_dir}/embedded/share/doc"
  command "rm -rf #{install_dir}/embedded/ssl/man"
  command "rm -rf #{install_dir}/embedded/info"

  # load default configuration files
  command "rsync -a #{Omnibus.project_root}/files/ #{install_dir}/"

  # apply patch for Sensu PR 697
  command "patch -d #{install_dir}/embedded/lib/ruby/gems/1.9.1/gems/sensu-#{version} -p0 -i #{Omnibus.project_root}/config/patches/sensu/sensu-00.patch"
  # apply patch for Contegix/omninbus-sensu
  command "patch -d #{install_dir}/embedded/lib/ruby/gems/1.9.1/gems/sensu-#{version} -p1 -i #{Omnibus.project_root}/config/patches/sensu/sensu-01.patch"
end
