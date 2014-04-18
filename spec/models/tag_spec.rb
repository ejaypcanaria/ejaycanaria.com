require 'spec_helper'

describe Tag do

  it { should have_many :model_tags }
  it { should have_many :blogs }
  it { should validate_presence_of :name }

end
