#
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "python::#{node['python']['install_method']}"
include_recipe "python::pip"
include_recipe "python::virtualenv"
include_recipe "git"


python_virtualenv "/home/vagrant/my_ve" do
  owner "vagrant"
  group "vagrant"
  action :create
end

python_pip "balanced" do
  virtualenv "/home/vagrant/my_ve"
  action :install
end

bash "Initial loading of virtualenv requirements" do
   code <<-EOH
  source /home/vagrant/my_ve/bin/activate
  git clone https://github.com/balanced/balanced-python.git
  cd ..
  cd ..
  cd balanced-python
  pip install -r test-requirements.txt
  pip install -r requirements.txt
  EOH
end

