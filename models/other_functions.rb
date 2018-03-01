def convert_to_UK_date(date)
  year = date[0,4]
  month = date[5,2]
  day = date[8,2]
  return "#{day}/#{month}/#{year}"
end

def add_currency_sign(currency_sign = "£",monetary_amount)
  return currency_sign + monetary_amount.to_s()
end

def percentage_of_total(string_number, string_total_number)
  value_of_subset = string_number[1..-1].to_f()
  value_of_total = string_total_number[1..-1].to_f()
  proportion = value_of_subset / value_of_total
  return "#{'%.2f' % (proportion * 100)}%"
end
