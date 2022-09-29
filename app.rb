require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?


require 'sinatra/activerecord'
require './models'

require 'pry'


enable :sessions

get '/' do
    if session[:user]
        @user_tasks = UserTask.where(user_id: session[:user]).where(check: false).where(task_id: ..20)
        @check = UserTask.where(user_id: session[:user]).where(check: true).size
        @is_complete = UserTask.where(user_id: session[:user]).where(check: false).where(task_id: ..20).size == 0
        # binding.pry
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
    redirect '/'
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

post '/check' do
    puts '==============================================='
    values = params[:values]
    if  values!= nil
        values.each do |value|
            user_task = UserTask.find(value)
            user_task.check = !(user_task.check)
            user_task.count = user_task.count + 1
            user_task.save   
        end  
    else 
        puts "何もなかった"
        
    end  
    redirect '/'
end