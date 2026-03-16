-- Aggiunge automaticamente data-background-color alle slide di sezione (h1)
-- e imposta il colore del testo a bianco

function Header(el)
  if el.level == 1 then
    el.attributes["data-background-color"] = "#0000ff"
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