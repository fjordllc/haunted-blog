json.users do
  json.array! @users, partial: "api/liking_users/user", as: :user
end
json.destroy_path @destroy_path
