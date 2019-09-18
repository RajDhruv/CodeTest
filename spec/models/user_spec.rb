require 'rails_helper'

RSpec.describe User, type: :model do
	let(:valid_attributes) {{ name: "Test User", email: "testuser2@mailid.com"}}
 	let(:user) { User.new(valid_attributes) }
 	before do
      User.create(valid_attributes)
    end
    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end
end