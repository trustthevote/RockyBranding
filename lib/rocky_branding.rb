require 'fileutils'

class RockyBranding
  TREE = [
    ["app/views/layouts", %w[_urchin.html.erb]],
    ["app/views/notifier", %w[confirmation.en.html.erb reminder.es.html.erb confirmation.es.html.erb reminder.en.html.erb]],
    ["app/views/registrants", %w[_overseas.html.erb]],
    ["app/views/finishes", %w[_adwords.html.erb]],
    ["config/initializers", %w[sponsor_customizations.rb]],
    ["config/locales", %w[en.yml es.yml]],
    ["data", %w[nvra_templates]],
    ["db/bootstrap/import", %w[states.csv]],
    ["public", %w[floatbox images]],
    ["public/stylesheets", %w[application.css partner.css registration.css]]
  ]

  def self.create_symlinks!
    package_root = File.join(File.dirname(__FILE__), "rocky_branding")
    TREE.each do |branch|
      rails_path = File.join(Rails.root, branch.first)
      FileUtils.mkdir_p(rails_path)
      branch.last.each do |file|
        source_path = File.expand_path(File.join(package_root, branch.first, file))
        target_path = File.expand_path(File.join(rails_path, file))
        if !File.symlink?(target_path) && File.directory?(target_path)
          FileUtils.rm_rf(target_path)
        end
        `ln -snf #{source_path} #{target_path}`
      end
    end
  end
end
