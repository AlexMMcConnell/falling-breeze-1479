require 'rails_helper'

RSpec.describe 'plots index' do
  before(:each) do
    @plots = create_list(:plot, 2)
    @plants = create_list(:plant, 4)

    @plots.zip(@plants[0..1]) do |plot, plant|
      create(:plot_plant, plot: plot, plant: plant)
    end

    @plots.zip(@plants[2..3]) do |plot, plant|
      create(:plot_plant, plot: plot, plant: plant)
    end

    visit '/plots'
  end

  it 'shows all plot numbers' do

    @plots.each do |plot|
      expect(page).to have_content(plot.number)
    end
  end

  it 'shows all plant names under each plot' do
    @plants.each do |plant|
      expect(page).to have_content(plant.name)
    end

    @plots.each do |plot|
      expect(page).to have_content(plot.number)
    end

    # @plots.each do |plot|
    #   expect("#{plot.number}").to appear_before(plot.plants.first)
    #   expect("#{plot.number}").to appear_before(plot.plants.last)
    # end
  end

  it 'has the option to remove plants from a page without deleting plant' do
    plant = Plant.first
    expect(page).to have_content(Plant.first.name)
    click_button("destroy #{Plant.first.name}", :match => :first)

    expect(page).to_not have_content(Plant.first.name)

    expect(Plant.first).to eq(plant)
  end
end
