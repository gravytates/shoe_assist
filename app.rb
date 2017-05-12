require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @stores = Store.all
  @brands = Brand.all
  erb :index
end

post '/new_store' do
  name = params['store_name']
  Store.create({name: name})
  redirect '/'
end

post '/new_brand' do
  name = params['brand_name']
  price = params['brand_price'].to_f
  Brand.create({name: name, price: price})
  redirect '/'
end

get '/store/:id' do
  @store = Store.find(params['id'].to_i)
  @brands = Brand.all
  erb :store
end

patch '/store/:id/update' do
  store = Store.find(params['id'].to_i)
  name = params['store_name']
  store.update(name: name)
  redirect "/store/#{store.id}"
end

delete '/store/:id/delete' do
  store = Store.find(params['id'].to_i)
  store.delete
  redirect '/'
end

patch '/store/:id/add_brand' do
  brand = Brand.find(params['brand-id'])
  store = Store.find(params['id'].to_i)
  store.brands.push(brand)
  redirect "/store/#{store.id}"
end
