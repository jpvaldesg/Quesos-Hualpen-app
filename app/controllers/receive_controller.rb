class ReceiveController < ApplicationController
  def update
   
    require 'twitter'

    Twitter.configure do |config|
      config.consumer_key = 'Qm7locVYddR3x7Nl36i4yw'
      config.consumer_secret = 'JNe6ZvbsiVsLrXISMCs2nD2NfQntPs5rsD2O0fL1PA'
      config.oauth_token = '1424454499-60n2fEDDZlZOHrLNShosNL9MyUu6AKnmCN9sakG'
      config.oauth_token_secret = 'AOWXckklgFPqwxMLrq55NvnTSZHylWmMKNvVP5NG2A'
    end
    
    str = "El producto sku = #{params[:sku]} ha sido repuesto en la bodega #{params[:almacendId]}"

    Twitter.update(str)

  end
end
