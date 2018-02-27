def convert_to_UK_date(date)
  year = date[0,4]
  month = date[5,2]
  day = date[8,2]
  return "#{day}/#{month}/#{year}"
end

def add_currency_sign(currency_sign = "£",monetary_amount)
  return currency_sign + monetary_amount.to_s()
end
