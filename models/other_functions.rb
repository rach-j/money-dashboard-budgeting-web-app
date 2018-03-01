def convert_to_UK_date(date)
  year = date[0,4]
  month = date[5,2]
  day = date[8,2]
  return "#{day}/#{month}/#{year}"
end

def to_display(currency_sign = "£",number)
  return currency_sign + '%.2f' % number
end

def convert_back_to_num(string_number)
  return string_number[1..-1].to_f()
end

def percentage_of_total(string_number, string_total_number)
  value_of_subset = convert_back_to_num(string_number)
  value_of_total = convert_back_to_num(string_total_number)
  proportion = value_of_subset / value_of_total
  return "#{'%.2f' % (proportion * 100)}%"
end
