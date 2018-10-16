require 'rails_helper'

RSpec.describe RemindersController, type: :controller do

  describe "GET #todays" do
    it "returns http success" do
      get :todays
      expect(response).to have_http_status(:success)
    end
  end

end
