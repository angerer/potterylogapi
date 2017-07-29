require 'rails_helper'

RSpec.describe Log, :type => :model do
  # Association test, m:1 relationship with works
  it { should belong_to(:work) }
  
  # Validation test
end
