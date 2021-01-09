require 'product.rb'

class CProduct < ApplicationRecord

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

end
