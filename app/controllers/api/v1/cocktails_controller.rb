class Api::V1::CocktailsController < ApplicationController

  def index
  @cocktails = Cocktail.all
  render json: @cocktails, :include =>
                             {:ingredients =>
                                  {:except =>
                                       [:created_at, :updated_at], :include =>
                                      [:product =>
                                           { :except => [:created_at, :updated_at]
                                           }
                                      ]
                                  }
                             },
         :except => [:created_at, :updated_at]
  end

end
