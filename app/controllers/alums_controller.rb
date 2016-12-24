class AlumsController < ApplicationController
  def index

    if params[:keyword] != nil
      @search = params[:keyword].split(" ")
      @alums = Array.new
      @search.each do |search|
        @alum = Alum.where("name LIKE ? OR year LIKE ? OR location LIKE ? OR industry LIKE ? OR company LIKE ? OR title LIKE ? OR other LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
        @alums = @alums + @alum
      end
    else
      @alums = Alum.all
    end


    @years = Array.new
    @locations = Array.new
    @industries = Array.new
    @alums.each do |alum|
      @years.push(alum.year)
      @locations.push(alum.location)
      @industries.push(alum.industry)
    end

    @keywordselect = params[:keyword]
    @yearselect = params[:year]
    @locationselect = params[:location]
    @industryselect = params[:industry]

      render("alums/index.html.erb")
  end

  def show
    @alum = Alum.find(params[:id])

    render("alums/show.html.erb")
  end

  def new
    @alum = Alum.new

    render("alums/new.html.erb")
  end

  def create
    @alum = Alum.new

    @alum.name = params[:name]
    @alum.year = params[:year]
    @alum.major = params[:major]
    @alum.location = params[:location]
    @alum.industry = params[:industry]
    @alum.company = params[:company]
    @alum.title = params[:title]
    @alum.website = params[:website]
    @alum.other = params[:other]
    @alum.email = params[:email]

    save_status = @alum.save

    if save_status == true
      redirect_to("/alums/#{@alum.id}", :notice => "Alum created successfully.")
    else
      render("alums/new.html.erb")
    end
  end

  def edit
    @alum = Alum.find(params[:id])

    render("alums/edit.html.erb")
  end

  def update
    @alum = Alum.find(params[:id])

    @alum.name = params[:name]
    @alum.year = params[:year]
    @alum.major = params[:major]
    @alum.location = params[:location]
    @alum.industry = params[:industry]
    @alum.company = params[:company]
    @alum.title = params[:title]
    @alum.website = params[:website]
    @alum.other = params[:other]
    @alum.email = params[:email]

    save_status = @alum.save

    if save_status == true
      redirect_to("/alums/#{@alum.id}", :notice => "Alum updated successfully.")
    else
      render("alums/edit.html.erb")
    end
  end

  def destroy
    @alum = Alum.find(params[:id])

    @alum.destroy

    if URI(request.referer).path == "/alums/#{@alum.id}"
      redirect_to("/", :notice => "Alum deleted.")
    else
      redirect_to(:back, :notice => "Alum deleted.")
    end
  end
end
