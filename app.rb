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
  @store = Store.create({name: name})
  if @store.save
    redirect '/'
  else
    erb :error
  end
end

post '/new_brand' do
  name = params['brand_name']
  price = params['brand_price'].to_f
  @brand = Brand.create({name: name, price: price})
  if @brand.save
    redirect '/'
  else
    erb :error
  end
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

get '/brand/:id' do
  @brand = Brand.find(params['id'].to_i)
  @stores = Store.all
  erb :brand
end

patch '/brand/:id/update' do
  brand = Brand.find(params['id'].to_i)
  name = params['brand_name']
  brand.update(name: name)
  redirect "/brand/#{brand.id}"
end

patch '/brand/:id/update_price' do
  brand = Brand.find(params['id'].to_i)
  price = params['brand_price']
  brand.update(price: price)
  redirect "/brand/#{brand.id}"
end

delete '/brand/:id/delete' do
  brand = Brand.find(params['id'].to_i)
  brand.delete
  redirect '/'
end
