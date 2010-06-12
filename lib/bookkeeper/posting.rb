class Bookkeeper::Posting < ActiveRecord::Base
  belongs_to  :account
  belongs_to  :journal
  belongs_to  :asset_type
  
  ensures_immutability_of :all
  
  before_validation :default_to_us_dollars, :unless => :asset_type, :on => :create
  
  validates_presence_of :account
  validates_presence_of :asset_type
  validate :validate_belongs_to_a_journal
  
  def destroy
    raise ActiveRecord::IndestructibleRecord
  end
  
  private
    def validate_belongs_to_a_journal
      parent_journal = self.journal

      # FIXME what is that doing anyway?
      #if !parent_journal
      #  ObjectSpace.each_object(Journal) {|j| parent_journal = j if j.postings.include?(self)}
      #end
      
      errors.add :journal, 'must be set.' if !parent_journal      
    end
    
    def default_to_us_dollars
      self.asset_type = Bookkeeper::AssetType::USD.find(:first)
    end
end
