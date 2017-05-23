require 'rails_helper'
require "spec_helper"

RSpec.describe PagesController, type: :controller do
  let(:valid_attributes) { { "name" => "MyString" } }

  describe "GET index" do
    it "assigns tree" do
      @page1 = Page.create({ "name" => "page1", "title" => "title1" })
      get :index, {}, {}
      expect(assigns(:tree)).to eq(Page.hash_tree)
    end
  end

  describe "GET show" do
    it "assigns page, tree" do
      @page1 = Page.create({ "name" => "page1", "title" => "title1" })
      get :show, {"name" => @page1.name}, {}
      expect(assigns(:page)).to eq(@page1)
      expect(assigns(:tree)).to eq(@page1.hash_tree)
    end
  end

  describe "GET new" do
    it "assigns page is new" do
      get :new, {}, {}
      expect(assigns(:page)).to be_a_new(Page)

      @page1 = Page.create({ "name" => "page1" })
      get :new, { :name => @page1.name }, {}
      expect(assigns(:page)).to be_a_new(Page)
    end
  end

  describe "GET edit" do
    it "assigns edited page" do
      @page1 = Page.create({ "name" => "page1" })
      get :edit, { :name => @page1.name }, {}
      expect(assigns(:page)).to eq(@page1)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create page" do
        expect {
          post :create, { :page => {"name" => "page1"} }, {}
        }.to change(Page, :count).by(1)
      end

      it "redirect to new page" do
        post :create, {:page => {"name" => "page1"}}, {}
        expect(response).to redirect_to("/"+Page.last.name)
      end
    end

    describe "with invalid params" do
      it "assigns created and unsaved page" do
        Page.any_instance.stub(:save).and_return(false)
        post :create, {:page => { "name" => "invalid value" }}, {}
        expect(assigns(:page)).to be_a_new(Page)
      end

      it "render 'new' template when validation fails" do
        Page.any_instance.stub(:save).and_return(false)
        post :create, {:page => { "name" => "invalid value" }}, {}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH update" do
    describe "with valid params" do
      it "update page" do
        @page = Page.create({ "name" => "page1" })
        patch :update, {:name => @page.name, :page => { :id => @page.id,
                                    :title => "NewTitle",
                                    :content => "NewContent" }}, {}
        expect(assigns(:page).title).to include("NewTitle")
        expect(assigns(:page).content).to include("NewContent")
      end

      it "redirect to updated page" do
        @page = Page.create({ "name" => "page1" })
        patch :update, {:name => @page.name, :page => { :id => @page.id,
                                                        :title => "NewTitle",
                                                        :content => "NewContent" }}, {}
        expect(response).to redirect_to("/"+@page.name)
      end
    end
  end

  describe "POST destroy" do
    describe "with valid params" do
      it "create page" do
        @page = Page.create({ "name" => "page1" })
        expect {
          get :destroy, { :name => "page1" }, {}
        }.to change(Page, :count).by(-1)
      end

      it "redirect to index" do
        @page = Page.create({ "name" => "page1" })
          get :destroy, { :name => "page1" }, {}
        expect(response).to redirect_to("/")
      end
    end
  end
end
