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

function IpAddress(address::AbstractString)
    return ccall((:sfIpAddress_fromString, libcsfml_network), IpAddress, (Ptr{Cchar},), address)
end

function to_string(a::IpAddress)
        "$(Char(a.a_0))$(Char(a.a_1))$(Char(a.a_2))$(Char(a.a_3))$(Char(a.a_4))$(Char(a.a_5))$(Char(a.a_6))$(Char(a.a_7))$(Char(a.a_8))$(Char(a.a_9))$(Char(a.a_10))$(Char(a.a_11))$(Char(a.a_12))$(Char(a.a_13))$(Char(a.a_14))$(Char(a.a_15))"
end
