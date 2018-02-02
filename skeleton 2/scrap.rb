name =  "ScottSoffel".split("").map.with_index do |char, index|

  if char == char.upcase && index != 0
    char = "_#{char}".downcase
  else
    char.downcase
  end
end.join


p name
