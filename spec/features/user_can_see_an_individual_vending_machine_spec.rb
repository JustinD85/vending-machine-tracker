require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do

  before :each do
    owner = Owner.create(name: "Sam's Snacks")
    @dons  = owner.machines.create(location: "Don's Mixed Drinks")

  end

  scenario 'they see the location of that machine' do

    visit machine_path(@dons)
    expect(page).to have_content("Don's Mixed Drinks Vending Machine")

    expect(current_path).to eq(machine_path(@dons))

  end

  scenario 'they see all snacks associated with that machine' do

    @dons.snacks << Snack.create(name: "Candy Bar", price: 1.33)
    visit machine_path(@dons)

    expect(page).to have_content("Candy Bar: $#{1.33}")
  end

  scenario 'they see average price for all snacks in machine' do
    @dons.snacks << Snack.create(name: "Candy Bar", price: 1.0)
    @dons.snacks << Snack.create(name: "Mars Bar", price: 3.0)
    visit machine_path(@dons)

    expect(page).to have_content("Average Price: $#{@dons.average_price}")

  end
end
