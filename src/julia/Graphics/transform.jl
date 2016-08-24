immutable _Transform
    a_1::Cfloat
    a_2::Cfloat
    a_3::Cfloat
    a_4::Cfloat
    a_5::Cfloat
    a_6::Cfloat
    a_7::Cfloat
    a_8::Cfloat
    a_9::Cfloat
end

type Transform
    matrix::Array{Real, 1}
end

const transform_identity = Transform([1, 0, 0, 0, 1, 0, 0, 0, 1])

function to_array(t::_Transform)
    Transform([t.a_1, t.a_2, t.a_3, t.a_4, t.a_5, t.a_6, t.a_7, t.a_8, t.a_9])
end
