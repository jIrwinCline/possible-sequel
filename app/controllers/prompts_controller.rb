class PromptsController < ApplicationController
  before_action :authorize

  def secret
  end

  def index
    random_num = ActiveRecord::Base.connection.execute("SELECT id FROM prompts ORDER BY random() LIMIT(1)").first
    @prompts = Prompt.all
    @prompt = Prompt.find(random_num["id"])
    @post = @prompt.posts.new
    movie_one = @prompt.movie_a
    movie_two = @prompt.movie_b
    response_one = API::Interface.call(movie_one)
    response_two = API::Interface.call(movie_two)
    @response_one = JSON.parse(response_one)
    @response_two = JSON.parse(response_two)
    @title_one = JSON.parse(response_one)["Title"]
    @title_two = JSON.parse(response_two)["Title"]
    @actors_one = JSON.parse(response_one)["Actors"]
    @actors_two = JSON.parse(response_two)["Actors"]
    @plot_one = JSON.parse(response_one)["Plot"]
    @plot_two = JSON.parse(response_two)["Plot"]
    render :index
  end

  def new
    @prompt = Prompt.new
    render :new
  end

  def create
    @prompt = Prompt.create(prompt_params)
    if @prompt.save
      flash[:notice] = "Prompt successfully created!"
      redirect_to prompts_path
    else
      flash[:alert] = "Please fill out all fields"
      render :new
    end
  end

  def edit
    @prompt = Prompt.find(params[:id])
    render :edit
  end

  def show
    @prompt = Prompt.find(params[:id])
    render :show
  end

  def update
    @prompt = Prompt.find(params[:id])
    if @prompt.update(prompt_params)
      redirect_to prompts_path
    else
      render :edit
    end
  end

  def destroy
    @prompt = Prompt.find(params[:id])
    @prompt.destroy
    redirect_to prompts_path
  end


  private
  def prompt_params
    params.require(:prompt).permit(:movie_a_url, :movie_b_url)
  end

end
