#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libnetsnmp"
version "5.7.2"

#dependency "perl"

# TODO: this link is subject to change with each new release of net-snmp.
# we'll need to use a more robust link (sourceforge) that will
# not change over time.
source :url => "http://downloads.sourceforge.net/project/net-snmp/net-snmp/#{version}/net-snmp-#{version}.tar.gz",
       :md5 => "5bddd02e2f82b62daa79f82717737a14"

relative_path "net-snmp-#{version}"
configure_env =
  case platform
  when "aix"
    {
      "LDFLAGS" => "-maix64 -L#{install_dir}/embedded/lib -Wl,-blibpath:#{install_dir}/embedded/lib:/usr/lib:/lib",
      "CFLAGS" => "-maix64 -I#{install_dir}/embedded/include",
      "LD" => "ld -b64",
      "OBJECT_MODE" => "64",
      "ARFLAGS" => "-X64 cru "
    }
  when "mac_os_x"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib"
    }
  when "solaris2"
    if Omnibus.config.solaris_compiler == "studio"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -static-libgcc",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -DNO_VIZ"
    }
    elsif Omnibus.config.solaris_compiler == "gcc"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib -DNO_VIZ"
    }
    else
      raise "Sorry, #{Omnibus.config.solaris_compiler} is not a valid compiler selection."
    end
  else
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib",
      "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig"
    }
  end

build do
#  command ["./configure --prefix=#{install_dir}/embedded",
#		"--with-default-snmp-version=3",
#		"--with-sys-contact=noreply@blacklightops.com",
#		"--with-sys-location=blacklight",
#		"--with-logfile=#{install_dir/var/log/snmpd/snmpd.log}"].join(" ") , :env => configure_env
  command ["./configure --prefix=#{install_dir}/embedded --with-defaults",
		"--disable-embedded-perl",
		"--disable-snmptrapd-subagent",
		"--without-perl-modules"].join(" ") , :env => configure_env
  command "make -j #{max_build_jobs}" , :env => configure_env
  command "make -j #{max_build_jobs} installlibs"
  command "make -j #{max_build_jobs} installheaders"
end
