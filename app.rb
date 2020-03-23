class App
  def find(brand, model)
    sale_prices = client.sale_prices(brand)
    sleep(2)
    list_prices = client.list_prices(brand)
    sleep(2)
    days_to_sell = client.days_to_sell(brand)

    return {
      sale_price: find_by_model(sale_prices, model),
      list_price: find_by_model(list_prices, model),
      sell_data:  find_by_model(days_to_sell, model)
    }
  end

  def present(brand, model, data)
    puts "Searching for all #{brand} #{model}..."
    puts "List: $#{data[:list_price].average}"
    puts "Sale: $#{data[:sale_price].average}"
    puts "Difference: $#{'%.2f' % (data[:list_price].average.to_f - data[:sale_price].average.to_f)}"
    puts "Days to Sell: #{data[:sell_data].average}\n"
  end

  private

  def find_by_model(data, model)
    data.find{|entry| entry.name.downcase == model.downcase}
  end

  def client
    @client ||= APIClient.new
  end
end
