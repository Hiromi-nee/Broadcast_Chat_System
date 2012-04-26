# BCS Listener
require 'socket'

UDPSock = UDPSocket.new

def spawn_server
	addr = ['0.0.0.0', '33333']  # host, port
	BasicSocket.do_not_reverse_lookup = true
	puts "Broadcast listener started."
	# Create socket and bind to address
	#UDPSock = UDPSocket.new
	UDPSock.bind(addr[0], addr[1])

	while true do
		data, addr = UDPSock.recvfrom(1024) # if this number is too low it will drop the larger packets and never give them to you
		puts "From addr: '%s' and '%s'" % [addr[3], addr[1]]
		puts "%s" % data
	end

	UDPSock.close
end

	spawn_server()


