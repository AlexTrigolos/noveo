# frozen_string_literal: true

require 'sinatra'

posts = [{ title: 'First Post', body: 'content of first post' },
         { title: 'Second Post', body: 'content of second post' }]

get '/' do
  'My work in /posts'
end

get '/posts' do
  return posts.to_json
end

get '/posts/:id' do
  return posts[params['id'].to_i].to_json
end

def get_body(req)
  req.body.rewind
  JSON.parse(req.body.read)
end

post '/posts' do
  body = get_body(request)
  new_post = { title: body['title'], body: body['body'] }
  posts.push(new_post)
  return new_post.to_json
end

put '/posts/:id' do
  id = params['id'].to_i
  body = get_body(request)
  posts[id][:title] = body['title']
  posts[id][:body] = body['body']
  return posts[id].to_json
end

delete '/posts/:id' do
  id = params['id'].to_i
  post = posts.delete_at(id)
  return post.to_json
end
