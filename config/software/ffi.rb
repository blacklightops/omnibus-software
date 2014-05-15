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

name "ffi"
version "1.9.3"

dependencies ["ruby", "rubygems", "libffi"]

env = { "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig" }

build do
  gem ["install",
       "ffi",
       "-v #{version}",
       "--",
       "--with-ffi_c-lib=#{install_dir}/embedded/lib", 
       "--with-ffi_c-include=#{install_dir}/embedded/include"].join(" ") , :env => env
end
