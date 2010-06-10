class BookkeeperGenerator < Rails::Generators::Base

  # TODO maybe we should invoke rails model generator (with skipping the models themselves)

  include Rails::Generators::Migration

  source_root  File.join File.dirname(__FILE__), 'templates'

  desc "generates migration to create bookkeeper tables"
  def copy_migration_file
    migration_template 'migration.rb', 'db/migrate/create_bookkeeper_table.rb'
  end

  def create_fixtures
    # disabled for know
    return
    # Create a blank fixtures file for each model
    %w(accounts asset_types batches journals paypal_transactions postings).each do |table_name|
      template 'fixtures.yml', File.join('test/fixtures', "#{table_name}.yml")
    end
  end

  # Implement the required interface for Rails::Generators::Migration.
  # copied from activerecord-3.0.0.beta4/lib/rails/generators/active_record.rb
  def self.next_migration_number(dirname) #:nodoc:
    next_migration_number = current_migration_number(dirname) + 1
    if ActiveRecord::Base.timestamped_migrations
      [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
    else
      "%.3d" % next_migration_number
    end
  end
  
end
