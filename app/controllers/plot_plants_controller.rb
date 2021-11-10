class PlotPlantsController < ApplicationController
  def delete
    plot_plant = PlotPlant.find_by(plant_id: params[:plant], plot_id: params[:plot])
    plot_plant.destroy
    redirect_to "/plots"
  end
end
