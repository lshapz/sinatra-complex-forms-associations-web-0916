class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
     Owner.create(name: params["owner_name"])
      @pet.owner_id = Owner.last.id
    end
#  binding.pry

    @pet.save
    redirect to "pets/#{@pet.id}"
  end


  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 

    if Pet.all.find_by_id(params[:id]) == nil
      redirect to "/pets/new"
    else
      @pet = Pet.find(params[:id])
       # binding.pry
    erb :'/pets/show'
    end 
  end

  post '/pets/:id' do 

    @pet = Pet.find(params[:id])
    #own_id = @pet.owner.id
    #owner = Owner.find_by(id: own_id)
      
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end


    #  #binding.pry
    # if params["pet"]["owner_id"] != own_id 
    #   @pet.owner = Owner.find_or_create_by(id: params["pet"]["owner_id"])
    #   if @pet.owner.name.empty?
    #     @pet.owner.name = params["pet"]["owner_name"]
    #     @pet.owner.save
    #   end
    #end
    @pet.save
    #erb :'pets/show'
    redirect to "pets/#{@pet.id}"
  end


  post '/pets/:id/delete' do
    Pet.destroy(params[:id])
    redirect to "pets"
  end 

end