# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def permitted_params
    params.permit!.to_h
  end
end
