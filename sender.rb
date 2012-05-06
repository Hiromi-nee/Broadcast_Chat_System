#!/usr/bin/ruby
# 'end' quits the chat
# BCS Sender script

require 'socket'

UDPSock = UDPSocket.new

def start_sender(addr)
	
	UDPSock.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
	data = ""
	name = ""
	puts "Input your name: "
	name = gets.chomp
	UDPSock.send(name+" has entered.", 0, addr[0], addr[1])
	
	#send node info to listeners
	UDPSock.send("sendinfo|"+name+"|"+addr[1].to_s,0,addr[0],addr[1])
	
	while data != 'end' do
		puts "Input your message: "
		data = gets.chomp
		final = name+"> "+data
		final = name+" has left." if data.eql?("end")
		UDPSock.send(final, 0, addr[0], addr[1])
	end
	UDPSock.close
end

addr = ['<broadcast>', 33333]
start_sender(addr)
