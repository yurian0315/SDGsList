require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?


require 'sinatra/activerecord'
require './models'

require 'pry'


enable :sessions

get '/' do
    if session[:user]
        @user_tasks = UserTask.where(user_id: session[:user])
        @check = @user_tasks.where(check: true).size
        # binding.pry
        @achievement = 100*@check / 20
        @tasks = Task.all
        erb :index_signined
    else
        erb :index
    end
end

get '/signin' do
    erb :sign_in
end

get '/signup' do
    erb :sign_up
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

post '/signup' do
    @user = User.create(
        name: params[:name],
        password: params[:password],
        password_confirmation: params[:password_confirmation])
    if @user.persisted?
        session[:user] = @user.id
    end
    
    Task.all.each do |task|
        UserTask.create(
            user_id: @user.id,
            task_id: task.id
        )
    end
    erb :index
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

post '/check/:id'  do
    user_task = UserTask.find(params[:id])
    user_task.check = !(user_task.check)
    
    user_task.count = user_task.count + 1
    
    user_task.save
end

get '/checkbox' do
    erb :checkbox
end

post '/checkbox' do
    # チェックを付けた項目を、 params で配列として受け取れる。
    values = params[:values]
    if values != nil
        values.each do |value|
            puts "===================="
            puts value
            puts "===================="
        end
    else
        puts "何もなかった"
    end
    redirect '/'
end

get '/first_select' do
    erb :first_select
end

post '/first_select' do
    values = params[:values]
    if values != nil
        values.each do |value|
            puts "===================="
            puts value
            puts "===================="
        end
    else
        puts "何もなかった"
    end
    redirect '/'
end


get '/option' do
    erb :option
end

post '/opiton' do
    
    redirect '/'
end


