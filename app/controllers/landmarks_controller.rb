class LandmarksController < ApplicationController
  # CREATE
  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name])
    if params[:landmark][:figure_ids]
      params[:landmark][:figure_ids].keys.each do |id|
        int_id = id.to_i
        @landmark.figures << Figure.find(int_id)
      end
    end
    if params[:landmark][:title_ids]
      params[:landmark][:title_ids].keys.each do |id|
        int_id = id.to_i
        @landmark.titles << Title.find(int_id)
      end
    end

    if !params[:figure][:name].empty?
      @figure = Figure.find_or_create_by(name: params[:figure][:name])
      @landmark.figures << @figure
    end

    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @landmark.titles << @title
    end

    redirect :"/landmarks/#{@landmark.id}"
  end

  # READ
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/:id' do
    # binding.pry
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  # UPDATE
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end
  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    # if params[:landmark][:figure_ids]
    #   params[:landmark][:figure_ids].keys.each do |id|
    #     int_id = id.to_i
    #     @landmark.figures << Figure.find(int_id)
    #   end
    # end
    # if params[:landmark][:title_ids]
    #   params[:landmark][:title_ids].keys.each do |id|
    #     int_id = id.to_i
    #     @landmark.titles << Title.find(int_id)
    #   end
    # end
    #
    # if !params[:figure][:name].empty?
    #   @figure = Figure.find_or_create_by(name: params[:figure][:name])
    #   @landmark.figures << @figure
    # end
    #
    # if !params[:title][:name].empty?
    #   @title = Title.find_or_create_by(name: params[:title][:name])
    #   @landmark.titles << @title
    # end

    redirect :"/landmarks/#{@landmark.id}"
  end

  # DELETE
  delete '/landmarks/:id' do
    # STUFF #############################
    erb :'/landmarks'
  end
end
