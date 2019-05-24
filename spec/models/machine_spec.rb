require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many(:machine_snacks)}
    it { should have_many(:snacks).through(:machine_snacks)}
  end


  describe 'instance methods' do
    before :each do
      owner = Owner.create(name: "Sam's Snacks")
      @dons  = owner.machines.create(location: "Don's Mixed Drinks")

      @dons.snacks << Snack.create(name: "Candy Bar", price: 1.0)
      @dons.snacks << Snack.create(name: "Mars Bar", price: 3.0)
    end
    it '.average_price' do
      expect(@dons.average_price.to_f).to eq(2.0)
    end

  end
end
