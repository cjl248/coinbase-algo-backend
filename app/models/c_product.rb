require 'product.rb'

class CProduct < ApplicationRecord

  def self.get_list
    begin
      response = Product.new.get_product_list.body
      return self.get_USD_list(JSON.parse(response))
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

  # GET /products/<product-id>/ticker
  def self.get_price(product_id)
    begin
      return Product.new.get_ticker(product_id)
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

  def self.get_bands(product_id, granularity)
    begin
      response = Product.new.get_historic_rates(product_id, granularity)
      prices = JSON.parse(response.body)
      mean = self.get_mean(prices).round(2)
      standard_deviation = self.standard_deviation(prices).round(2)
      bands_one = self.get_level_one_bands(mean, standard_deviation)
      bands_two = self.get_level_two_bands(mean, standard_deviation)
      return {
        "level1": bands_one,
        "level2": bands_two
      }
    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end

  def self.get_fibonacci_retracement(product_id, granularity)
    begin
      h_response = Product.new.get_historic_rates(product_id, granularity)
      h_values = JSON.parse(h_response.body)
      h_max = self.get_high_values(h_values)
      h_min = self.get_low_values(h_values)
      h_middle = (h_max+h_min)/2
      h_object = {max: h_max, middle: h_middle, min: h_min}

      s_response = JSON.parse(Product.new.get_stats(product_id).body)
      {historical_stats: h_object, day_stats: s_response}

    rescue RestClient::BadRequest, RestClient::NotFound => err
      return err.response
    rescue RestClient:: Unauthorized, RestClient:: Forbidden => err
      return err.response
    end
  end


  private

  # [ time, low, high, open, close, volume ]
  def self.get_high_values(values)
    highs = values.map { | value | value[2] }
    max = highs.reduce(0.0) do | high, current |
      high = current if current > high
      high unless current > high
    end
    max
  end

  def self.get_low_values(values)
    lows = values.map { |value| value[1] }
    min = lows.reduce(Float::INFINITY) do | low, current |
      low = current if current < low
      low unless current < low
    end
    min
  end

  def self.get_mean(prices)
    daily_averages = prices.map do |day|
      ((day[1].round(2)+day[2].round(2))/2)
    end
    daily_sum = daily_averages.reduce { |sum, price| sum = sum + price }
    average = daily_sum/daily_averages.length
    return average
  end

  def self.get_variance(prices)
    mean = get_mean(prices)
    sum = prices.inject(0) do |accum, i|
      current = (i[1] + i[2])/2
      accum + (current - mean)**2
    end
    return sum/(prices.length - 1)
  end

  def self.standard_deviation(prices)
    Math.sqrt(get_variance(prices))
  end

  def self.get_level_one_bands(mean, standard_deviation)
    return [
      mean - standard_deviation,
      mean,
      mean + standard_deviation
    ]
  end

  def self.get_level_two_bands(mean, standard_deviation)
    return [
      mean - 2*standard_deviation,
      mean,
      mean + 2*standard_deviation
    ]
  end

  def self.get_USD_list(all_products)
    all_products.select { |k, _| k['quote_currency'] == 'USD' }
  end

end
