class Twit
  def self.publish(str)
    
    require 'twitter'

    Twitter.configure do |config|
      config.consumer_key = 'Qm7locVYddR3x7Nl36i4yw'
      config.consumer_secret = 'JNe6ZvbsiVsLrXISMCs2nD2NfQntPs5rsD2O0fL1PA'
      config.oauth_token = '1424454499-60n2fEDDZlZOHrLNShosNL9MyUu6AKnmCN9sakG'
      config.oauth_token_secret = 'AOWXckklgFPqwxMLrq55NvnTSZHylWmMKNvVP5NG2A'
    end

    Twitter.update(str)

    return
  end
end
