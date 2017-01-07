class AlumsController < ApplicationController
  def index

    @alums = Alum.all

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


    # searches for year, location, industry
    if @yearselect != "" && @yearselect != nil
      @alums = @alums.where({ :year => @yearselect })
    end

    if @locationselect != "" && @locationselect != nil
      @alums = @alums.where({ :location => @locationselect })
    end

    if @industryselect != "" && @industryselect != nil
      @alums = @alums.where({ :industry => @industryselect })
    end


    if params[:keyword] != nil && params[:keyword] != ""
      @search = params[:keyword].split(" ")
      @alumsselect = Array.new

      # @alums.as_json.each do |alum|
      #   match = 0
      #   @search.each do |term|
      #     # loop through search terms, look to see if it matches any category -- if matches, break and set variable to 1, if no match, set to 0 and move to next search term
      #     # (currently doesn't work)
      #     if alum.has_value?(term) == true
      #       match = match + 1
      #       break
      #     end
      #   end
      #   # each alum must have greater than or equal to # of search term matches, and add to the list
      #   if @search.count >= match
      #     @alumsselect = @alumsselect + alum.to_a
      #   end
      # end

      @search.each do |term|
        @alum = @alums.where("lower(name) LIKE ? OR year LIKE ? OR lower(location) LIKE ? OR lower(industry) LIKE ? OR lower(company) LIKE ? OR lower(title) LIKE ? OR lower(other) LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
        @alumsselect = @alumsselect + @alum
      end

      @alums = @alumsselect.uniq

    end

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
