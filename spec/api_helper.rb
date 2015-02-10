require 'net/http'
require 'uri'
  def api_get action, params={}, version="1"
    get "/v#{version}/#{action}", params
    JSON.parse(response.body) rescue {}
  end

  def api_post action, params={}, version="1"
    post "/v#{version}/#{action}", params
    JSON.parse(response.body) rescue {}
  end

  def api_delete action, params={}, version="1"
    delete "/v#{version}/#{action}", params
    JSON.parse(response.body) rescue {}
  end

  def api_put action, params={}, version="1"
    put "/api/v#{version}/#{action}", params
    JSON.parse(response.body) rescue {}
  end