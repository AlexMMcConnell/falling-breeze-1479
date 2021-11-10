class Garden < ApplicationRecord
  has_many :plots

  def plants(id)
    plants = Plant.garden_plants(id)
    plants.map do |plant|
      plant.name
    end.uniq
  end
end
