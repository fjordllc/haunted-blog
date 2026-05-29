json.users do
  json.array! @users, :id, :nickname
end
json.destroy_path @destroy_path
