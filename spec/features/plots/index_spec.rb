require 'rails_helper'

RSpec.describe 'index page' do
  before(:each) do
    @plots = create_list(:plot, 5)
    @plants = create_list(:plant, 10)

    @plots.zip(@plants[0..4]) do |plot, plant|
      create(:plot_plant, plot: plot, plant: plant)
    end

    @plots.zip(@plants[5..9]) do |plot, plant|
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
end
