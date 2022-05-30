json.extract! @album, :id, :title
json.images @album.albumPhotos do |albumPhoto|
  json.id albumPhoto.id
  json.url albumPhoto.image_url 
end