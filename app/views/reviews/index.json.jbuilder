json.array!(@reviews) do |review|
  json.extract! review, :id, :attraction_id, :user_id, :comments, :rating
  json.url review_url(review, format: :json)
end
