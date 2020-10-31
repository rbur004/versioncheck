= versioncheck

* Docs :: http://rbur004.github.io/versioncheck/
* Source :: https://github.com/rbur004/versioncheck
* Gem :: https://rubygems.org/gems/VersionCheck

== DESCRIPTION:

VersionCheck is a ruby class provides tests against a packages  version 
so we can determine if our code is running in the version we want
or is running on a version later than the version we need.

Special initializer, VersionCheck.rubyversion, sets up VersionCheck instance 
we can use to check against current Ruby major,minor,update and patch level.

== FEATURES/PROBLEMS:


== SYNOPSIS:

	require 'rubygems'
	require 'versioncheck'
	vc = VersionCheck.new(major,minor,update,build)

	#to conditionally run code based on having exactly the version x,y
	if vc.have_version?(x,y)
	 ...
	end

	#to conditionally run code based on having at least the given version x,y
	if vc.have_at_least_version?(x,y)
	 ...
	end

	rb_vc = VersionCheck.rubyversion #Equivalent to VersionCheck.new with RubyVersion and patchlevel  as params
	#Check the ruby version is at least version 1.9
	if rb_vc.have_at_least_version?("1.9") 
	 ...
	end

	#Check the ruby version is at least version 1.8.6
	if rb_vc.have_at_least_version?("1.8.6") 
	 ...
	end



== REQUIREMENTS:

* require 'rubygems'

== INSTALL:

* sudo gem install versioncheck

== LICENSE:

(The MIT License)

Copyright (c) 2012 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
