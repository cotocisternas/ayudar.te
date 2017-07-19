module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def json_api
    json['data']
  end

  def json_api_attributes(type, attributes)
    {
      data: {
        type: type.to_s,
        attributes: attributes,
      }
    }
  end
end


RSpec::Matchers.define :be_json_api_response_for do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual)
    parsed_actual.dig('data', 'type') == model &&
      parsed_actual.dig('data', 'attributes').is_a?(Hash)
  end
end

RSpec::Matchers.define :have_json_api_errors_for do |pointer|
  match do |actual|
    parsed_actual = JSON.parse(actual)
    errors = parsed_actual['errors']
    return false if errors.empty?
    errors.any? do |error|
      error.dig('source', 'pointer') == pointer
    end
  end
end
