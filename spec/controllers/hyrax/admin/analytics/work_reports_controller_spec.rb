# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Hyrax::Admin::Analytics::WorkReportsController, type: :controller do
  routes { Hyrax::Engine.routes }
  describe 'GET #index' do
    context 'when user is not logged in' do
      it 'does not raise an error' do
        expect {
          get :index
        }.to_not raise_error
      end
    end
  end
end
