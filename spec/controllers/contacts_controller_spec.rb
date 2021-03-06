require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  let(:valid_attributes) {
    {
      first_name: "Alex",
      last_name: "Bannon",
      email_address: "alexbannon@gmail.com",
      phone_number: "301-919-4523",
      company_name: "Alex Inc"
    }
  }

  let(:invalid_attributes) {
    {
      shblibityschblop: "bloopadoop",
      first_name: 1,
      email_address: false
    }
  }

  describe "GET #homepage" do

    it "assigns all contacts as @contacts" do
      contact = Contact.create! valid_attributes
      get :homepage, {}
      expect(assigns(:contacts)).to eq([contact])
    end

  end

  describe "POST #create" do

    context "with valid params" do

      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes, :format => :json}
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        post :create, {:contact => valid_attributes, :format => :json}
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

    end

    context "with invalid params" do

      it "does not create a new Contact" do
        expect {
          post :create, {:contact => invalid_attributes, :format => :json}
        }.to change(Contact, :count).by(0)
      end

    end

  end

  describe "PUT #update" do

    context "with valid params" do

      let(:new_attributes) {
        {
          first_name: "Edited",
          last_name: "Editson",
          email_address: "edited@edit.com",
          phone_number: "555-555-5555",
          company_name: "Editing Inc"
        }
      }

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => new_attributes, :format => :json}
        updated_user = JSON.parse(response.body)
        contact.reload
        expect(updated_user).to include("first_name" => "Edited")
      end

      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes, :format => :json}
        expect(assigns(:contact)).to eq(contact)
      end

    end

    context "with invalid params" do
      let(:invalid_new_attributes) {
        {
          squibbidysquobbly: "potato",
          edited: "Editson",
          email_address: false,
          phone_number: 5555555555,
          company_name: 1
        }
      }

      it "does not update Contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_new_attributes, :format => :json}
        expect(Contact.find(contact.id).email_address).to eq("alexbannon@gmail.com")
      end

    end



  end

  describe "DELETE #destroy" do

    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param, :format => :json}
      }.to change(Contact, :count).by(-1)
    end

  end


end
