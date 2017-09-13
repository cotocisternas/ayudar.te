module Response
  def json_response(object, status = :ok, location = false)
    if location
      render json: object, status: status, location: object
    else
      render json: object, status: status
    end
  end

  def custom_json_error(field, error_message)
    render json: {
        errors: {
          status: 422,
          source: {pointer: "/data/attributes/#{field}"},
          detail: error_message
        }
      },
      status: :unprocessable_entity
  end

  def json_error(object)
    render json: {errors: error_serialize(object)}, status: :unprocessable_entity
  end

  def error_serialize(object)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          status: 422,
          source: {pointer: "/data/attributes/#{field}"},
          detail: error_message
        }
      end
    end.flatten
  end
end
