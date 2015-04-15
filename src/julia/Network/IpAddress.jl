type IpAddress
	a_0::Cchar
	a_1::Cchar
	a_2::Cchar
	a_3::Cchar
	a_4::Cchar
	a_5::Cchar
	a_6::Cchar
	a_7::Cchar
	a_8::Cchar
	a_9::Cchar
	a_10::Cchar
	a_11::Cchar
	a_12::Cchar
	a_13::Cchar
	a_14::Cchar
	a_15::Cchar
end

function IpAddress(address::String)
	return ccall(dlsym(libcsfml_network, :sfIpAddress_fromString), IpAddress, (Ptr{Cchar},), pointer(address))
end

export IpAddress
