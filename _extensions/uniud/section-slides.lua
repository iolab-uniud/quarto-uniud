-- Automatically adds data-background-color to section slides (h1)
-- and sets text color to white

function Header(el)
  if el.level == 1 then
    el.attributes["data-background-color"] = "#0000ff"
    el.attributes["data-color"] = "#ffffff" 
    return el
  end
  if el.level == 2 then
    local classes = el.classes
    if classes:includes("black-slide") then
      el.attributes["data-background-color"] = "#000000"
    elseif classes:includes("gray-slide") then
      el.attributes["data-background-color"] = "#b3b6b7"
    end
    return el
  end
end

-- Remove horizontal rules before h1, which are used to split sections in the source

function Pandoc(doc)
  local blocks = {}
  for i, block in ipairs(doc.blocks) do
    if block.t == "HorizontalRule" then
      local next = doc.blocks[i + 1]
      if next and next.t == "Header" and next.level == 1 then
        -- scarta
      else
        blocks[#blocks + 1] = block
      end
    else
      blocks[#blocks + 1] = block
    end
  end
  doc.blocks = blocks
  return doc
end