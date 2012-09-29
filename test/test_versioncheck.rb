require 'rubygems'
require 'minitest/autorun'
require "versioncheck"

#Self fulfilling prophecy
CURRENT_VERSION_MAJOR, CURRENT_VERSION_MINOR, CURRENT_VERSION_UPDATE = RUBY_VERSION.split('.').collect { |i| i.to_i }
CURRENT_VERSION_BUILD = RUBY_PATCHLEVEL.to_i

#Easier to see what is going wrong if tests run in order. There is no order interaction possible anyway
MiniTest::Unit::TestCase.i_suck_and_my_tests_are_order_dependent!
puts MiniTest::Unit::TestCase.test_order #Tests run in alpha order, which is why the have A. and 1. markers in the lines

describe VersionCheck do
  
  before do
    @rubyversion = VersionCheck.new(CURRENT_VERSION_MAJOR, CURRENT_VERSION_MINOR, CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD)
  end

  describe "A. When asking if we have this version, against the same version parameters" do
    #Current Version test
    it "1. has current major version, when passing parameters as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR).must_equal true
    end

    it "2. has current major and minor version, when passing parameters as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR).must_equal true
    end

    it "3. has current major, minor and update version, when passing parameters as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE).must_equal true
    end

    it "4. has current major, minor, update and build version, when passing parameters as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD).must_equal true
    end

    it "5. has current major and minor version, when passing parameters as a String" do
      @rubyversion.have_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}").must_equal true
    end

    it "6. has current major, minor and update version, when passing parameters as a String" do
      @rubyversion.have_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}.#{CURRENT_VERSION_UPDATE}").must_equal true
    end

    it "7. has current major and minor version, when passing parameters as a Float" do
      @rubyversion.have_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}".to_f).must_equal true
    end
  end

  describe "B. When asking if we have this version against a later version" do
  #We assume that we don't need to repeat these for the different input methods, as the above tests checked that they worked.
  
    it "1. doesn't match later major  version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR - 1).must_equal false
    end

    it "2. doesn't match later major and minor version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR - 1).must_equal false
    end

    it "3. doen't match later major, minor and update version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE - 1).must_equal false
    end
    
    it "4. doen't match later major, minor, update, build version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD - 1).must_equal false
    end
  end

  describe "C.When asking if we have this version, against an earlier version" do

    it "1. doesn't match earlier major version, when given as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR + 1).must_equal false
    end
  
    it "2. doesn't match earlier major and minor version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR + 1).must_equal false
    end

    it "3. doen't match earlier major, minor and update version, when given as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE + 1).must_equal false
    end
  
    it "4. doen't match earlier major, minor, update, build version" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD + 1).must_equal false
    end
  end
  
  describe "D: Check current version using have_at_least_version?" do
  #Newer Version Tests against current version
    it "1. has at least major, when given as integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR).must_equal true
    end
  
    it "2. has at least major and minor version, when given as integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR).must_equal true
    end

    it "3. has at least major, minor and update version, when given as integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE).must_equal true
    end

    it "4. has at least major, minor, update and build version, when given as integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD).must_equal true
    end

    it "5. has at least major version, when given as a String" do
      @rubyversion.have_at_least_version?("#{CURRENT_VERSION_MAJOR}").must_equal true
    end

    it "6. has at least major and minor version, when given as a String" do
      @rubyversion.have_at_least_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}").must_equal true
    end

    it "7. has at least major, minor and update version, when given as String" do
      @rubyversion.have_at_least_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}.#{CURRENT_VERSION_UPDATE}").must_equal true
    end

    it "8. has at least major and minor version, when given as a Float" do
      @rubyversion.have_at_least_version?("#{CURRENT_VERSION_MAJOR}.#{CURRENT_VERSION_MINOR}".to_f).must_equal true
    end
  end

  describe "E: Check next version, against current version, using have_at_least_version? " do
    #Newer Version Tests against previous and later versions
    it "1. has at least major version, when given as larger integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR + 1).must_equal false #We asked for version after the one we have
    end

    it "2. has at least major and minor version, when given as larger integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR + 1).must_equal false  #We asked for version after the one we have
    end

    it "3. has at least major, minor and update version, when given as larger integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE + 1).must_equal false  #We asked for version after the one we have
    end

    it "4. has at least major, minor, update and build version, when given as larger integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD + 1).must_equal false  #We asked for version after the one we have
    end
  end

  describe "F: Check previous version against current version, usig have_at_least_version?" do
    it "1. doesn't have at least the major version, when given as smaller integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR - 1).must_equal true
    end
  
    it "2. doesn't have at least major and minor version, when given as smaller integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR - 1).must_equal true
    end

    it "3. doesn't have at least major, minor and update version, when given as smaller bintegers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE - 1).must_equal true
    end

    it "4. doesn't have at least major, minor, update and build version, when given as smaller integers" do
      @rubyversion.have_at_least_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD - 1).must_equal true
    end
  end
end

describe VersionCheck, "Ruby version initilized for you" do
  
  before do
    @rubyversion = VersionCheck.rubyversion
  end

  describe "A. When asking if we have this version, against the same version parameters" do
    #Current Version test

    it "1. has current major, minor, update and build version, when passing parameters as integers" do
      @rubyversion.have_version?(CURRENT_VERSION_MAJOR,CURRENT_VERSION_MINOR,CURRENT_VERSION_UPDATE, CURRENT_VERSION_BUILD).must_equal true
    end

  end
  
end
