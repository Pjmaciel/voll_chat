require 'rails_helper'
require 'rswag/specs'


RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer
          }
        }
      },
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Development server'
        }
      ]
    }
  }
end