require "spec_helper"

describe PagesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/")).to route_to("pages#index")
    end

    it "routes to #new" do
      expect(get("/add")).to route_to("pages#new")
      expect(get("/name1/add")).to route_to("pages#new", :name => "name1")
    end

    it "routes to #show" do
      expect(get("/name1")).to route_to("pages#show", :name => "name1")
      expect(get("/name1/name2")).to route_to("pages#show", :name => "name1/name2")
    end

    it "routes to #edit" do
      expect(get("/name1/edit")).to route_to("pages#edit", :name => "name1")
    end

    it "routes to #create" do
      expect(post("/")).to route_to("pages#create")
      expect(post("/name1")).to route_to("pages#create", :name => "name1")
    end

    it "routes to #destroy" do
      expect(get("/name1/remove")).to route_to("pages#destroy", :name => "name1")
    end

    it "routes to #update" do
      expect(patch("/name1")).to route_to("pages#update", :name => "name1")
    end
  end
end
