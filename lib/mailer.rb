module Mailer
  def load_orders()
    

    #Download new mails (attachments)
    require 'gmail'
    
    gmail = Gmail.connect('quesoshualpentest', 'quesos123')
    @state = 'Conectado'
    #@num = gmail.inbox.count
    #gmail.inbox.find(:unread).each do |email|
    gmail.inbox.find(:unread).each do |email|
      folder = File.join(Rails.root,'Docs/pedidos')
      email.message.attachments.each do |f|
        File.write(File.join(folder, email.subject), f.body.decoded)
      end
    end
    gmail.logout

    ret=[]
    #Create "pedido" in DB    
    require 'xmlsimple'
    path = Dir.glob(File.join(Rails.root,'Docs/pedidos/*'))
    path.each do |p|

      aux = XmlSimple.xml_in(p, {'KeyAttr' => 'name'})

      #Importante: cambiar adressId -> addresId!!!
      pedido = {'arrivalDate' => aux['Pedidos'][0]['fecha'],
		'arrivalTime' => aux['Pedidos'][0]['hora'],
		'rut' => aux['Pedidos'][0]['Pedido'][0]['rut'][0],
		'addressId' => aux['Pedidos'][0]['Pedido'][0]['direccionId'][0],
		'orderDate' => aux['Pedidos'][0]['Pedido'][0]['fecha'][0],
		'sku' => aux['Pedidos'][0]['Pedido'][0]['sku'][0],
		'qty' => aux['Pedidos'][0]['Pedido'][0]['cantidad'][0]['content'],
		'unit' => aux['Pedidos'][0]['Pedido'][0]['cantidad'][0]['unidad'],
		'state' => 'recibido'}
    
      order = Order.new(pedido)
      order.save
      ret.push(order)
      File.delete(p)

    end

    return ret
  end
end
