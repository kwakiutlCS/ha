require 'spec_helper'

describe TrendReportsController do
  describe "#index" do
    it "redirects non sign in users" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
end
