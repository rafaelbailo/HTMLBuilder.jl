function parse_HTML(raw)
  filtered = filter_raw_HTML(raw)
  segments = get_HTML_segments(filtered)
  blocks = get_HTML_blocks(segments)
  tags = map(s -> s[1], blocks)
  @assert cancel_out_HTML_tags(tags) == String[]
  return HTMLDoc(parse_HTML_blocks(blocks))
end
export parse_HTML

function filter_raw_HTML(raw)
  filtered = raw
  filtered = replace(filtered, ">\n" => ">")
  filtered = replace(filtered, "\n<" => "<")
  for el ∈ (:div, HTMLElementsIndent...)
    filtered = replace_tags(filtered, el)
  end
  return (raw == filtered) ? filtered : filter_raw_HTML(filtered)
end

function replace_tags(text, el)
  filtered = text
  filtered = replace(filtered, "</$el> " => "</$el>")
  filtered = replace(filtered, " </$el>" => "</$el>")
  if contains(filtered, "<$el")
    attributes =
      unique(map(s -> split(s, ">")[1], split(filtered, "<$el")[2:end]))
    for at ∈ attributes
      filtered = replace(filtered, "<$el$at> " => "<$el$at>")
      filtered = replace(filtered, " <$el$at>" => "<$el$at>")
    end
  end
  return filtered
end

function get_HTML_segments(filtered)
  return map(s -> split(s, ">"), split(filtered, "<")[2:end])
end

get_HTML_blocks(segments) = map(parse_HTML_segment, segments)

function parse_HTML_segment(segment)
  tag_parts = split(segment[1], " ")
  tag = tag_parts[1]
  raw_attributes = map(s -> split(s, "="), tag_parts[2:end])
  attributes_with_values = map(
    s -> if (length(s) < 2)
      ([s[1], ""])
    else
      ([s[1], HTMLBuilder.parse_attribute_string(join(s[2:end], "="))])
    end,
    raw_attributes,
  )
  attributes =
    NamedTuple(map(s -> Symbol(s[1]) => s[2], attributes_with_values))
  content = Content[segment[2]]
  return [tag, attributes, content]
end

parse_attribute_string(s) = s[2:(end - 1)]

function cancel_out_HTML_tags(tags)
  for k ∈ reverse(2:length(tags))
    left = tags[k - 1]
    right = tags[k]
    if do_HTML_tags_match(left, right)
      return cancel_out_HTML_tags(
        String[tags[1:(k - 2)]..., tags[(k + 1):end]...],
      )
    end
  end
  return tags
end

function parse_HTML_blocks(blocks)
  if length(blocks) == 1
    return collection(blocks[1][3]...)
  end
  for k ∈ reverse(2:length(blocks))
    left = blocks[k - 1]
    right = blocks[k]
    if do_HTML_tags_match(left[1], right[1])
      tag = left[1]
      attributes = left[2]
      children = left[3]
      post = right[3]
      synthesised =
        collection(HTMLElement(Val(Symbol(tag)), attributes, children), post...)
      if k > 2
        previous = blocks[k - 2]
        new_blocks = [
          blocks[1:(k - 3)]...,
          [previous[1], previous[2], Content[previous[3]..., synthesised]],
          blocks[(k + 1):end]...,
        ]
      else
        new_blocks = [["", NamedTuple(), [synthesised]], blocks[(k + 1):end]...]
      end
      return parse_HTML_blocks(new_blocks)
    end
  end
  return blocks
end

do_HTML_tags_match(left, right) = ("/" * left) == right
