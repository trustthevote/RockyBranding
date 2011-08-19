require 'test/unit'
require 'tmpdir'
require 'fileutils'
require '../lib/rocky_branding.rb'

class Rails
  def self.reset_root
    @root = nil
  end
  def self.root
    @root ||= File.join(Dir.tmpdir, "rbtest-#{Time.now.to_i}-#{Time.now.usec}")
  end
end

class RockyBrandingTest < Test::Unit::TestCase
  def setup
    Rails.reset_root
  end

  def test_symlinks_into_rails_root
    assert_equal [], Dir[File.join(Rails.root, "*")]
    RockyBranding.create_symlinks!
    Dir[File.join(File.dirname(__FILE__), "../lib/rocky_branding/**/*")].each do |path|
      relative_path = path.match(%r{lib/rocky_branding/(.*)$})[1]
      assert File.exists?(File.join(Rails.root, relative_path))
    end
  end

  def test_idempotent
    assert_equal [], Dir[File.join(Rails.root, "*")]
    RockyBranding.create_symlinks!
    first_pass = Dir[File.join(Rails.root, "**/*")]
    RockyBranding.create_symlinks!
    assert_equal first_pass, Dir[File.join(Rails.root, "**/*")]
  end

  def test_directory_replacement
    assert_equal [], Dir[File.join(Rails.root, "*")]
    FileUtils.mkdir_p File.join(Rails.root, "public/images")
    RockyBranding.create_symlinks!
    assert !File.exists?(File.join(Rails.root, "public/images/images"))
  end
end
