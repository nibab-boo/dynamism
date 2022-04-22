json.array! @blogs do |blog|
  json.extract! blog, :id, :title, :description, :link
  json.extract! blog.user, :id, :email
end