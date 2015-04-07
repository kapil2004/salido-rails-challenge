require 'rails_helper'

RSpec.describe "wines api", type: :request do
  
  describe "GET #index" do
    
    before do
      # create 20 test wines
      20.times do |i|
        Wine.create!(name: "Wine #{i}")
      end
    end
    
    it "responds successfully with an HTTP 200 status code" do
      get '/api/wines'
      expect(response.status).to eq 200
    end
    
    it "responds with 10 wines when limit is not specified" do
      get '/api/wines'
      wines = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq 200
      expect(wines.size).to eq 10
    end
    
    it "responds with 1 wine when limit is 1" do
      get '/api/wines', {limit: 1}
      wines = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq 200
      expect(wines.size).to eq 1
    end
    
    it "filters by name of wine when filter is provided" do
      filter = 'Wine 10'
      get '/api/wines', {filter: filter}
      wines = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq 200
      expect(wines.first[:name]).to eq filter
      expect(wines.size).to eq 1
    end
    
  end
  
  describe "PATCH/PUT #update" do
    
    it "responds successfully with an HTTP 200 status code" do
      new_name = "New Wine Name"
      wine = Wine.create!(name: "Meiomi Pinot Noir 3000")
      
      patch "/api/wines/#{wine.id}", { wine: { name: new_name } }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      
      expect(response.status).to eq 200
      expect(wine.reload.name).to eq new_name
    end
    
    it "responds with a error message if wine name is blank" do
      wine = Wine.create!(name: "Meiomi Pinot Noir 3000")
      
      patch "/api/wines/#{wine.id}", { wine: { name: "" } }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      
      expect(response.status).to eq 422
      wine_error = JSON.parse(response.body, symbolize_names: true)
      expect(wine_error[:name]).not_to be_empty
      expect(wine_error[:name].first).to eq "can't be blank"
    end
    
  end
  
end



