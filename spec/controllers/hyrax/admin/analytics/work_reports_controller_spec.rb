# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Hyrax::Admin::Analytics::WorkReportsController, type: :controller do
  routes { Hyrax::Engine.routes }
  describe 'GET #index' do
    context 'when user is not logged in' do
      it 'does not raise an error' do
            get :index
            expect(response).to redirect_to(root_path)
            expect(flash[:alert]).to eq("Analytics are not configured properly or you must be logged in to access this page.")
      end
    end
  end
end