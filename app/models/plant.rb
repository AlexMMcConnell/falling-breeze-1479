class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants

  def self.garden_plants(garden_id)
    self.joins(plots: :garden)
    .where("plants.days_to_harvest < 100")
    .where("plots.garden_id = garden_id")
    .distinct
  end
end
