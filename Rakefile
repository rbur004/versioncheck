# -*- ruby -*-

require 'rubygems'
require 'hoe'
#require './lib/versioncheck.rb'
Hoe.plugin :yard

Hoe.spec 'versioncheck' do 
  #self.rubyforge_name = 'versionchecker'
  developer 'Rob Burrowes', 'r.burrowes@auckland.ac.nz'
  #remote_rdoc_dir = '' # Release to root

  self.yard_title = 'versionchecker'
  self.yard_options = ['--markup', 'markdown', '--protected']
  #extra_deps << 'whatevs' 
end

#Validate manfest.txt
#rake check_manifest

#Local checking. Creates pkg/
#rake gem

#create doc/
#rake docs  
#In directory docs/
#scp -r . rbur004@rubyforge.org:/var/www/gforge-projects/versioncheck/

#Copy up to rubygem.org
#rake release VERSION=1.0.1