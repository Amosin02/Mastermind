module Color
  def cyan
      "\e[36m#{self}\e[0m" 
  end

  def clue_colors(key)
    symbol = {
        '?' => "\e[91m\u25CF\e[0m ",
        '*' => "\e[37m\u25CB\e[0m "
    }[key]
  end
end