module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound do
      json_response(
        {
          errors:[
            {
              status: 404,
              source: {pointer: "/data/id"},
              detail: 'document not found'
            }
          ]
        }, :not_found)
    end

    # rescue_from Mongoid::Errors::UnknownAttribute do
    #   json_response(
    #     {
    #       errors:[
    #         {
    #           status: 422,
    #           source: {pointer: "/data/attributes"},
    #           detail: 'unknown attribute'
    #         }
    #       ]
    #     }, :unprocessable_entity)
    # end
    #
    # rescue_from ActionController::ParameterMissing do |e|
    #   json_response(
    #     {
    #       errors:[
    #         {
    #           status: 422,
    #           source: {pointer: "/data/attributes"},
    #           detail: e.message
    #         }
    #       ]
    #     }, :unprocessable_entity)
    # end
  end

end
