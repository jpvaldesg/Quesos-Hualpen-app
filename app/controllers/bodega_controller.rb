class BodegaController < ApplicationController
	include Stocks
	require 'json'
	require 'httparty'
	def index
		@bodegas=getInfoBodegas()
		respond_to do |format|
		format.html # index.html.erb
		end
	end
end 
