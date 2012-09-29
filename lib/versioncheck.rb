#VersionCheck is a ruby class provides tests against a packages  version 
#so we can determine if our code is running in the version we want
#or is running on a version later than the version we need.
#
#Naming convention used:
#  RUBY_VERSION 1.8.7 patch level 249
#  is Rubyvesion.major = 1, VersionCheck.minor = 8, VersionCheck.update = 7
#  VersionCheck.build = 249 or VersionCheck.patchlevel = 249
#
#Special initializer, VersionCheck.rubyversion, sets up VersionCheck instance 
#we can use to check against current Ruby major,minor,update and patch level.

class VersionCheck
  VERSION = '1.0.0' #version of class VersionCheck
  
  attr_accessor :major, :minor, :update, :build
  alias patchlevel build
  
  #Set up the version we are going to check against.
  def initialize(major,minor=0,update=0,build=0)
    if major.class == Float
      major = major.to_s
    end
    if major.class == String
      major,minor,update = major.split('.').collect { |x| x.to_i }
    end
    @major = major != nil ? major.to_i : 0
    @minor = minor != nil ? minor.to_i : 0
    @update = update != nil ? update.to_i : 0 
    @build = build != nil ? build.to_i : 0
  end    
  
  #Short cut to setting up VersionCheck against current RUBY_VERSION and RUBY_PATCHLEVEL
  def self.rubyversion
    major,minor,update = RUBY_VERSION.split('.').collect { |i| i.to_i }
    self.new(major,minor,update, RUBY_PATCHLEVEL.to_i)
  end
  
  #have_version tests that the versien of RUBY is the one we want.
  #Returns true if match to arguments is exact, otherwise false.
  #  If update and build are not specified, they are not tested for.
  #Can take:
  #  a single float argument. 
  #   e.g. VersionCheck.have_version?(1.8)      Tests for version 1.8 with any update or build version
  #  a single string argument. 
  #   e.g. VersionCheck.have_version?("1")      Tests for version 1 with any minor, update or build version
  #   e.g. VersionCheck.have_version?("1.8")    Tests for version 1.8 with any update or build version
  #        VersionCheck.have_version?("1.8.7")  Tests for version 1.8.7 with and build version
  #  Integer arguments major, minor, update and build
  #   e.g. VersionCheck.have_version?(1)         Tests for version 1 with any minor, update or build version
  #        VersionCheck.have_version?(1,8)       Tests for version 1.8 with any update or build version
  #        VersionCheck.have_version?(1,8,7)     Tests for version 1.8.7 with and build version
  #        VersionCheck.have_version?(1,8,7,249) Test for 1.8.7 build 249
  def have_version?(major, minor = nil, update = nil, build = nil)
    if major.class == Float
      major = major.to_s
    end
    if major.class == String
      major,minor,update = major.split('.').collect { |x| x.to_i }
    end
    if major == @major
      return false if minor != nil && minor != @minor
      return false if update != nil && update != @update
      return false if build != nil && build !=  @build
      return true
    else
      return false
    end
  end

  #have_at_least_version tests that the versien of RUBY is newer than the one we want.
  #major, minor, update and build are integers. 
  #If update and or build are missing, then any update or build version
  #will return true, as long as the major and minor numbers match, 
  #or the running Ruby verion major.minor numbers are for a newer version.
  def have_at_least_version?(major, minor = nil, update = nil, build = nil)
    if major.class == Float
      major = major.to_s
    end
    if major.class == String
      major,minor,update = major.split('.').collect { |x| x.to_i }
    end
    if major == @major #Could true
      if minor != nil #Being asked to test minor level
        if minor == @minor #Could be true
          if update != nil #Being asked to test update level
            if update == @update #Could be true
              if build != nil #Being asked to test the build version
                return build <= @build #have at least the required patch level.
              end
              return true #update was equal
            end
            return update < @update #current version is newer
          end
          return true #major and minor was equal.
        end
        return minor < @minor #true if current version is newer
      end
      return true #major was equal.
    end
    return major < @major #true, if current version is newer
  end

  #to_s returns the current Ruby version and build as a string.
  def to_s
    "#{@major}.#{@minor}.#{@update} Build #{@build}"
  end
  
  
end
