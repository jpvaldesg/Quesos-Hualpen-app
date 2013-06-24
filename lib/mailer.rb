module Mailer
  def load_orders()
    

    #Download new mails (attachments)
    require 'gmail'
    
    #gmail = Gmail.connect('quesoshualpentest', 'quesos123')
    gmail = Gmail.connect('g4tallerint', 'grupocuatro')
    @state = 'Conectado'
    i=0
    #@num = gmail.inbox.count
    #gmail.inbox.find(:unread).each do |email|
    gmail.inbox.find(:unread, :after => Date.parse("2013-06-22")).each do |email|
      folder = File.join(Rails.root,'Docs/pedidos')
      email.message.attachments.each do |f|
        File.write(File.join(folder, i.to_s), f.body.decoded)
        i=i+1
      end
    end
    gmail.logout


    retorno=[]

    #Create "pedido" in DB    
    require 'xmlsimple'
    require 'stocks'
    extend Stocks
    path = Dir.glob(File.join(Rails.root,'Docs/pedidos/*'))
    path.each do |p|

      aux = XmlSimple.xml_in(p, {'KeyAttr' => 'name'})
      sku = aux['Pedidos'][0]['Pedido'][0]['sku'][0].to_i
      compra = getSkuInfo(sku)
      venta = Producto.by_sku(sku) 

      #Importante: cambiar adressId -> addresId!!!
      pedido = {'arrivalDate' => aux['Pedidos'][0]['fecha'],
  	  'arrivalTime' => aux['Pedidos'][0]['hora'],
  		'rut' => aux['Pedidos'][0]['Pedido'][0]['rut'][0],
  		'addressId' => aux['Pedidos'][0]['Pedido'][0]['direccionId'][0],
  		'orderDate' => aux['Pedidos'][0]['Pedido'][0]['fecha'][0],
  		'sku' => aux['Pedidos'][0]['Pedido'][0]['sku'][0],
  		'qty' => aux['Pedidos'][0]['Pedido'][0]['cantidad'][0]['content'],
  		'unit' => aux['Pedidos'][0]['Pedido'][0]['cantidad'][0]['unidad'],
  		'state' => 'recibido',
  		'cost' => compra["costo"].to_f,
  		'price' => venta["precio"]}
    
      order = Order.new(pedido)
      order.save
      File.delete(p)
      retorno<<order

    end

    return retorno

  end
end
