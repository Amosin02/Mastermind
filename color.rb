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

  def number_colors(num)
    {
      '1' => "\e[101m\e[30m  1  \e[0m ",
      '2' => "\e[43m\e[30m  2  \e[0m ",
      '3' => "\e[44m\e[30m  3  \e[0m ",
      '4' => "\e[45m\e[30m  4  \e[0m ",
      '5' => "\e[46m\e[30m  5  \e[0m ",
      '6' => "\e[41m\e[30m  6  \e[0m "
    }[num]
  end
end