require 'spec_helper'

describe ModelTag do

  it { should belong_to :taggable }
  it { should belong_to :tag }

end
