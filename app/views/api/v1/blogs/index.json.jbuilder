json.array! @blogs do |blog|
  json.extract! blog, :id, :title, :description, :link
  # json.user do
  #   json.id blog.user.id
  #   json.email blog.user.email
  # end
end 