class Reservas
  def self.read()
  
    require "rubygems"
    require 'google_drive'

    session = GoogleDrive.login("quesoshualpentest@gmail.com", "quesos123")

    @data = []

    session.files.each do |file|
      @data.push file.title
    end 

    ws = session.spreadsheet_by_title('reservas').worksheets[0]
    @data2 = []
    
    @data2.push [ws[1,1], ws[1,2]]
    @data2.push [ws[2,1], ws[2,2]]
    @data2.push [ws['A3'], ws.numeric_value('B3')+2]
    @data2.push [ws['A4'], ws[4,2]]
    @data2.push [ws['A5'], ws[5,2]]

    var = ws.numeric_value('B3')
    var = var - 3
    ws['B3'] = var
    ws.save

  return
  end
end
