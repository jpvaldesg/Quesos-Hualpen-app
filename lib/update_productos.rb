module Update_productos
 def regenerate
    require "rubygems"
    require 'google_drive'

    session = GoogleDrive.login("quesoshualpentest@gmail.com", "quesos123")

    ws = session.spreadsheet_by_key('0AiCS6SIMXrChdHp2ZzFabjV0QTUwQ1M2WXBvNXI5Z1E').worksheets[0]
    
    Producto.delete_all

    for row in 2..ws.num_rows
        producto = Producto.new
        producto[:sku] = ws[row,1]
        producto[:descripcion] = ws[row,2]
        precio = to_price(ws[row,3])
        #puts precio
        producto[:precio] = precio
        desde = to_date(ws[row,4])
        #puts desde
        producto[:desde] = desde
        hasta = to_date(ws[row,5])
        #puts hasta
        producto[:hasta] = hasta
        producto.save
    end
  end

  def to_price(str)
    aux = str.gsub(",","")
    aux = aux.gsub(".",",")
    price = aux.to_f
    return price
  end

  def to_date(str)
    aux = str.split("/")
    date = aux[1] + "-" + aux[0] + "-" + aux[2]
    return date
  end
end
