# frozen_string_literal: true

require 'sinatra'
require 'csv'

PATH = './rails/homework/1/sinatra/products.csv'
PATH_PUT = './rails/homework/1/sinatra/products_put.csv'
PATH_DELETE = './rails/homework/1/sinatra/products_delete.csv'

get '/' do
  'My work in /products'
end

get '/products' do
  products = ''
  CSV.open(PATH) do |csv|
    csv.each { |a, b, c, d| products += "#{a}, #{b}, #{c}, #{d}<br>" }
  end
  return products
end

get '/products/:id' do
  index = -1
  CSV.open(PATH) do |csv|
    csv.each do |a, b, c, d|
      return "#{a}, #{b}, #{c}, #{d}\n" if index == params['id'].to_i

      index += 1
    end
    halt 404, 'Product not found'
  end
end

def get_body(req)
  req.body.rewind
  req.body.read
end

post '/products' do
  body = get_body(request)
  new_product = body.split(',')
  CSV.open('./rails/homework/1/sinatra/products.csv', 'a') do |csv|
    csv << new_product
  end
  return new_product.join(', ')
end

put '/products/:id' do
  id = params['id'].to_i
  body = get_body(request)
  update_product = body.split(',')
  csv_read = CSV.open(PATH)
  csv_put = CSV.open(PATH_PUT, 'w')
  index = -1
  csv_read.each do |elem|
    csv_put << if index != id
                 elem
               else
                 update_product
               end
    index += 1
  end
  csv_read.close
  csv_put.close
  File.delete(PATH)
  File.rename(PATH_PUT, PATH)
  return update_product.join(', ')
end

delete '/products/:id' do
  id = params['id'].to_i
  csv_read = CSV.open(PATH)
  csv_delete = CSV.open(PATH_DELETE, 'w')
  index = -1
  deleted_product = nil
  csv_read.each do |elem|
    if index != id
      csv_delete << elem
    else
      deleted_product = elem
    end
    index += 1
  end
  csv_read.close
  csv_delete.close
  File.delete(PATH)
  File.rename(PATH_DELETE, PATH)
  return deleted_product.join(', ') unless deleted_product.nil?

  halt 404, 'Product not found'
end
