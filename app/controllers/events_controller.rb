class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events}
      format.xls 
    end
  end

  def export
    @events = Event.where(:created_at.gte => params[:from]).and(:created_at.lte => params[:to]).and(type: params[:type])
    @filtered=@events
    respond_to do |format|
      format.json { render json: @events }
      format.csv { send_data @events.to_csv }
      format.xls 
    end

  end

  def filter
    fromHash=params[:from]
    toHash=params[:to]
    
    @from=Time.new(fromHash[:year],fromHash[:month], fromHash[:day], fromHash[:hour], fromHash[:minute])
    @to=Time.new(toHash[:year],toHash[:month], toHash[:day], toHash[:hour], toHash[:minute])
    @eventType=params[:type]

    @events = Event.where(:created_at.gte => @from).and(:created_at.lte => @to).and(type: @eventType)
    @filtered=@events
    respond_to do |format|
      format.html # filter.html.erb
      format.json { render json: @events }
      format.csv { send_data @events.to_csv }
      format.xls 
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
