immutable BlendMode
    color_src_factor::Cint
    color_dst_factor::Cint
    color_equation::Cint
    alpha_src_factor::Cint
    alpha_dst_factor::Cint
    alpha_equation::Cint
end

const blend_alpha = BlendMode(6, 7, 0, 1, 7, 0)
const blend_add = BlendMode(6, 1, 0, 1, 1, 0)
const blend_multiply = BlendMode(4, 0, 0, 4, 0, 0)
const blend_none = BlendMode(1, 0, 0, 1, 0, 0)
