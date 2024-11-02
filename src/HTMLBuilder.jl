module HTMLBuilder

abstract type HTML end
const Content = Union{HTML, AbstractString}

include("./utils/check_key.jl")
include("./utils/equality_by_fields.jl")
include("./utils/settings.jl")

include("./HTMLElements/HTMLElement.jl")
include("./HTMLElements/register.jl")
include("./HTMLElements/elements.jl")
include("./HTMLElements/tags.jl")

include("./parse_HTML.jl")

end
