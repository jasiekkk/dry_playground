module API
  class Root::API < Grape::API
    mount Cars::API
    add_swagger_documentation
  end
end
