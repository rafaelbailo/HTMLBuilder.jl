open_tag(s::Symbol, args::NamedTuple = (;)) = tag(s, args);
close_tag(s::Symbol, args::NamedTuple = (;)) = tag(s, args, left_bar = true);

function tag(
  s::Symbol,
  attributes::NamedTuple = (;);
  left_bar = false,
  right_bar = false,
  left_exclamation = false,
)
  parsed_attributes = parse_tag_attributes(attributes)
  left_bar_string = left_bar ? "/" : ""
  left_exclamation_string = left_exclamation ? "!" : ""
  right_bar_string = right_bar ? "/" : ""
  return left_tag() *
         left_bar_string *
         left_exclamation_string *
         String(s) *
         parsed_attributes *
         right_bar_string *
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
