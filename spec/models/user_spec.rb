require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { should respond_to(:email) }
  it { should respond_to(:password) }

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_uniqueness_of(:email).case_insensitive }
end
