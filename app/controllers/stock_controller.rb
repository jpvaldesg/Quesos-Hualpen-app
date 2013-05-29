class StockController < ApplicationController
	include Stocks
	require 'json'
	require 'httparty'
	def show
		@almacenes = getStock(params[:sku])
		respond_to do |format|
			format.html # show.html.erb
		end
	end
end 

