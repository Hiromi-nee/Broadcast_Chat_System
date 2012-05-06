# BCS Listener
require 'socket'

UDPSock = UDPSocket.new

def saveNodeInfo(node)
	open('node.file', 'a') do |f|
		node.each do |line|
			f.puts line
		end
		f.puts "-"
	end
end

def spawn_server
	addr = ['0.0.0.0', '33333']  # host, port
	BasicSocket.do_not_reverse_lookup = true
	puts "Broadcast listener started."
	# Create socket and bind to address
	#UDPSock = UDPSocket.new
	UDPSock.bind(addr[0], addr[1])

	while true do
		data, addr = UDPSock.recvfrom(1024) # if this number is too low it will drop the larger packets and never give them to you
		puts "From addr: '%s' and '%s'" % [addr[3], addr[1]] #debug line remove in release
		#recv nodeinfo
		if data.match(/^sendinfo\|(\w*)\|([0-9]{1,5})/)
			#output to nodelist.txt
			data = data.sub!(/sendinfo\|/, "")
			node = Array.new
			data.split("|").each_with_index do |info,key|
				node[key]= info
			end			
			node[2] = addr[3]
			puts "Got new node info: %s %s %s" % [node[0], node[1], node[2]] 
			saveNodeInfo(node)
		data=data.sub!(/(.*)/, "") #removes raw command from being printed
		end
		puts "%s" % data
	end

	UDPSock.close
end

	spawn_server()
