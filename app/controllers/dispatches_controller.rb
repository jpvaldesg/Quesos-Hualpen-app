class DispatchesController < ApplicationController
  require 'will_paginate'

  # GET /dispatches
  # GET /dispatches.json
  def index
    @dispatches = Dispatch.paginate(:page => params[:page], :per_page => 10)

    #@json = Dispatch.date_ok.to_gmaps4rails do |dispatch, marker|
    @json = Dispatch.all.to_gmaps4rails do |dispatch, marker|
      marker.infowindow dispatch[:description]
      marker.title dispatch[:direction]
      if dispatch.final > Date.today
        marker.picture({
        :picture => "assets/wait_small.png",
        :width   => 50,
        :height  => 62
        })
      elsif dispatch.final == Date.today
        marker.picture({
        :picture => "assets/truck_small.png",
        :width   => 50,
        :height  => 62
        })
      else
        marker.picture({
        :picture => "assets/ok_small.png",
        :width   => 50,
        :height  => 62
        })
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dispatches }
      format.csv { send_data @dispatches.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  # GET /dispatches/1
  # GET /dispatches/1.json
  def show
    @dispatch = Dispatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dispatch }
    end
  end

  # GET /dispatches/new
  # GET /dispatches/new.json
  def new
    @dispatch = Dispatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dispatch }
    end
  end

  # GET /dispatches/1/edit
  def edit
    @dispatch = Dispatch.find(params[:id])
  end

  # POST /dispatches
  # POST /dispatches.json
  def create
    @dispatch = Dispatch.new(params[:dispatch])

    respond_to do |format|
      if @dispatch.save
        format.html { redirect_to @dispatch, notice: 'Dispatch was successfully created.' }
        format.json { render json: @dispatch, status: :created, location: @dispatch }
      else
        format.html { render action: "new" }
        format.json { render json: @dispatch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dispatches/1
  # PUT /dispatches/1.json
  def update
    @dispatch = Dispatch.find(params[:id])

    respond_to do |format|
      if @dispatch.update_attributes(params[:dispatch])
        format.html { redirect_to @dispatch, notice: 'Dispatch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dispatch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dispatches/1
  # DELETE /dispatches/1.json
  def destroy
    @dispatch = Dispatch.find(params[:id])
    @dispatch.destroy

    respond_to do |format|
      format.html { redirect_to dispatches_url }
      format.json { head :no_content }
    end
  end

  def gmaps4rails_marker_picture
    {
      "picture" => "/images/incon.gif",
      "width" => 20,
      "height" => 20,
      "marker_anchor" => [ 5, 10],
      "shadow_width" => "110",
      "shadow_height" => "110",
      "shadow_anchor" => [5, 10],
    }
  end

end
















