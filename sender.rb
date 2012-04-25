require 'socket'
addr = ['<broadcast>', 33333]
UDPSock = UDPSocket.new
UDPSock.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
data = ""
name = ""
puts "Input your name: "
name = gets.chomp
UDPSock.send(name+" has entered.", 0, addr[0], addr[1])
while data != 'end' do
	puts "Input your message: "
	data = gets.chomp
	final = name+"> "+data
	final = name+" has left." if data.eql?("end")
	UDPSock.send(final, 0, addr[0], addr[1])
end
UDPSock.close
