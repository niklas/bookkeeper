require 'find'

require File.join(File.dirname(__FILE__), 'immutable-attribute-plugin', 'init')

# These ones need to be loaded first.
require 'bookkeeper/account.rb'
require 'bookkeeper/paypal_transaction.rb'
require 'bookkeeper/journal.rb'

# require everything in lib/
Find.find(File.join(File.dirname(__FILE__), 'bookkeeper')) do |file|
  require file if !File.directory?(file) && File.extname(file) == '.rb'
end