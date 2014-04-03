class EntitiesController < ApplicationController
  def index
  end

  def total_file_scale
    file_name = params[:file_name]

    return if file_name.blank?

    file_hash = {s: file_name[0],
                 x: file_name[1],
                 l: file_name[2],
                 w: file_name[3]}

    @total_file_scale = Entity.total_file_scale(file_hash)
  end

  def file_scale
    file_name = params[:file_name]

    return if file_name.blank?

    file_hash = {s: file_name[0],
                 x: file_name[1],
                 l: file_name[2],
                 w: file_name[3]}

    @file_scale = Entity.file_scale(file_hash)
  end

  def total_scale
    @total_scale = Entity.total_scale
  end
end
