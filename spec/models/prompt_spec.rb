require 'rails_helper'

describe Prompt do

  it { should have_many :posts }
  it { should validate_presence_of :movie_a}
  it { should validate_presence_of :movie_b}

end
