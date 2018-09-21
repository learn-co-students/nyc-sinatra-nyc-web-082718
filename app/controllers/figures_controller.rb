class FiguresController < ApplicationController
  # CREATE
  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].keys.each do |id|
        int_id = id.to_i
        @figure.landmarks << Landmark.find(int_id)
      end
    end
    if params[:figure][:title_ids]
      params[:figure][:title_ids].keys.each do |id|
        int_id = id.to_i
        @figure.titles << Title.find(int_id)
      end
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << @landmark
    end

    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @title
    end

    redirect :"/figures/#{@figure.id}"
  end

  # READ
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:id' do
    # binding.pry
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  # UPDATE
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].keys.each do |id|
        int_id = id.to_i
        @figure.landmarks << Landmark.find(int_id)
      end
    end
    if params[:figure][:title_ids]
      params[:figure][:title_ids].keys.each do |id|
        int_id = id.to_i
        @figure.titles << Title.find(int_id)
      end
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << @landmark
    end

    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @title
    end

    redirect :"/figures/#{@figure.id}"
  end

  # DELETE
  delete '/figures/:id' do
    # STUFF #############################
    erb :'/figures'
  end
end
