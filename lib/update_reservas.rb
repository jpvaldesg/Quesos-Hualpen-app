module Update_reservas
 def regenerate
    require "rubygems"
    require 'google_drive'

    session = GoogleDrive.login("quesoshualpentest@gmail.com", "quesos123")

    #ws = session.spreadsheet_by_title('reservas').worksheets[0]
    ws = session.spreadsheet_by_key('0AhRzyWALVmYKdDFkekdkakRMejZ1WEd5MmlEMWgtNFE').worksheets[0]
    
    Reserva.delete_all

    for row in 2..ws.num_rows
        reserva = Reserva.new
        reserva[:sku] = ws[row,1]
        reserva[:qty] = ws[row,2]
        reserva.save
    end
  end
end
