require 'rails_helper'

RSpec.describe Work, :type => :model do
  # Association test. 1:m relationship with logs
  it { should have_many(:logs).dependent(:destroy) }
  
  #Valiation tests
  # verify required fields prior to saving
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:status) }
end
