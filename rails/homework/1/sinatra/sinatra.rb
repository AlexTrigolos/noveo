# frozen_string_literal: true

require 'sinatra'
require 'csv'

require_relative 'product'

PATH = './rails/homework/1/sinatra/products.csv'

get '/' do
  'My work in /products'
end

get '/products' do
  products = Product.new
  CSV.foreach(PATH) do |row|
    products.push(row)
  end
  products.to_s
  return products.to_s
end

get '/products/:id' do
  index = 0
  product = Product.new
  CSV.foreach(PATH, headers: true) do |row|
    if index == params['id'].to_i
      product.push(row.values_at(0..3))
      return product.to_s
    end
    index += 1
  end
  halt 404, 'Product not found'
end

post '/products' do
  new_product = get_body_data(request)
  CSV.open('./rails/homework/1/sinatra/products.csv', 'a') do |csv|
    csv << new_product
  end
  return new_product.join(', ')
end

put '/products/:id' do
  table = table_or404

  update_product = get_body_data(request)

  table[params['id'].to_i] = update_product

  write_table(table)
  return update_product.join(', ')
end

delete '/products/:id' do
  table = table_or404

  del = Product.new
  del.push(table[params['id'].to_i].values_at(0..3))

  was_deleted = false
  table.delete_if do |w|
    was_deleted = true if !was_deleted && w == table[params['id'].to_i]
  end

  write_table(table)
  return del.to_s
end

private

def get_body_data(req)
  req.body.rewind
  req.body.read.split(',')
end

def write_table(table)
  File.open(PATH, 'w') do |f|
    f.write(table.to_csv)
  end
end

def table_or404
  table = CSV.table(PATH, headers: true)

  return halt 404, 'Product not found' if table.size < params['id'].to_i + 1

  table
end
