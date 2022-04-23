json.array! @blogs do |blog|
  json.extract! blog, :id, :title, :description, :link, :image_url
  # json.user do
  #   json.id blog.user.id
  #   json.email blog.user.email
  # end
end 