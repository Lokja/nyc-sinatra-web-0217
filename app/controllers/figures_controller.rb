class FiguresController < ApplicationController

  set :views, 'app/views/figures'

  get '/figures' do
    erb :index
  end

  get '/figures/new' do
    erb :new
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
    @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    if tids = params["figure"]["title_ids"]
      tids.each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    if lids = params["figure"]["landmark_ids"]
      lids.each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params["figure"]["name"]
    @figure.landmarks.clear
    @figure.titles.clear
    @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    if tids = params["figure"]["title_ids"]
      tids.each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    if lids = params["figure"]["landmark_ids"]
      lids.each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
