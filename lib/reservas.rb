module Reservas
  def view_reserves(sku)
  
    require "rubygems"
    require 'google_drive'

    session = GoogleDrive.login("quesoshualpentest@gmail.com", "quesos123")

    ws = session.spreadsheet_by_title('reservas').worksheets[0]

    for row in 2..ws.num_rows
        if ws[row,1] = sku
            return ws.numeric_value[row,2]
        end
    end

  end
end
