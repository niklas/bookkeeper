class Bookkeeper::AssetType < ActiveRecord::Base
  ensures_immutability_of :all
end
