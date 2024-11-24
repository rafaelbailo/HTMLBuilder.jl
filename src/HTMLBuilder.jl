module HTMLBuilder

abstract type HTML end
const Content = Union{HTML, AbstractString}
export HTML, Content

include("./utils/check_key.jl")
include("./utils/equality_by_fields.jl")
include("./utils/files.jl")
include("./utils/settings.jl")

include("./HTMLElements/HTMLElement.jl")
include("./HTMLElements/register.jl")
include("./HTMLElements/elements.jl")
include("./HTMLElements/tags.jl")

include("./parse_HTML/parse_HTML.jl")

include("./build_site/build_site.jl")
include("./build_site/parse_redirection_page.jl")
include("./build_site/site_map.jl")

end
