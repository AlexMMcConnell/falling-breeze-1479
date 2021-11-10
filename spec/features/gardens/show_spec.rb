require 'rails_helper'

RSpec.describe 'garden show' do
  before(:each) do
    #creation of first garden for testing
    @garden1 = create(:garden)

    @plot1 = create(:plot, garden: @garden1)
    @plot2 = create(:plot, garden: @garden1)
    # early bloomers have less than 100 days to harvest
    # late bloomers have >= 100 days till harvest as defined in factory
    @early_bloomers = create_list(:plant, 6, days_to_harvest: 12)
    @early_bloomers << create(:plant, name: Plant.first.name, days_to_harvest: 53)
    @late_bloomers = create_list(:plant, 3)
    @blossom = create(:plant, name: 'Blossom', days_to_harvest: 0)

    plants = []
    plants << @early_bloomers
    plants << @late_bloomers
    plants << @blossom_bloomers
    @all_garden1_plants = plants.flatten

    @early_bloomers.each do |plant|
      create(:plot_plant, plot: @plot1, plant: plant)
    end

    @late_bloomers.each do |plant|
      create(:plot_plant, plot: @plot2, plant: plant)
    end
    create(:plot_plant, plot: @plot2, plant: @blossom)
    # creation of sescond garden for negative testing
    @garden2 = create(:garden)
    @garden_2_plants = create_list(:plant, 15, name: "Spaghetti")
    @plot3 = create(:plot, garden: @garden2)

    @garden_2_plants.each do |plant|
      create(:plot_plant, plot: @plot3, plant: plant)
    end

    visit "/gardens/#{@garden1.id}"
  end

  it 'shows all unique plants in the garden plots that have less than 100 days to harvest' do
    @all_garden1_plants.each do |plant|
      unless plant.nil?
        if plant.days_to_harvest < 100
          expect(page).to have_content(plant.name, count: 1)
        end
      end

    @garden_2_plants.each do |plant|
      expect(page).to_not have_content(plant.name)
    end

    end
  end
end
