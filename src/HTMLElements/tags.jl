open_tag(s::Symbol, args::NamedTuple = (;)) = tag(s, args)

close_tag(s::Symbol, args::NamedTuple = (;)) = tag(s, args, left_slash = true)

function tag(
  s::Symbol,
  attributes::NamedTuple = (;);
  left_slash = false,
  right_slash = false,
  left_exclamation = false,
)
  parsed_attributes = parse_tag_attributes(attributes)
  left_slash_string = left_slash ? "/" : ""
  left_exclamation_string = left_exclamation ? "!" : ""
  right_slash_string = right_slash ? "/" : ""
  return left_tag() *
         left_slash_string *
         left_exclamation_string *
         String(s) *
         parsed_attributes *
         right_slash_string *
         right_tag()
end

function parse_tag_attributes(attributes::NamedTuple)
  attributes = NamedTuple(filter(s -> s[2] != false, pairs(attributes)))
  attributes = map(s -> s == true ? "" : s, attributes)
  if length(attributes) > 0
    parse_key(s) = " " * String(s) * parse_tag_attributes(attributes[s])
    parsed_attributes = reduce(*, map(parse_key, keys(attributes)))
  else
    parsed_attributes = ""
  end
  return parsed_attributes
end

parse_tag_attributes(arg) =
  if length(arg) > 0
    return "=" * metastring(arg)
  else
    return ""
  end

metastring(s::AbstractString) = "'$s'"

metastring(s::Real) = metastring(string(s))

left_tag() = "<"

right_tag() = ">"

left_comment_tag() = "\n<!--"

right_comment_tag() = "-->\n"
