json.status 200
json.user do
  json.partial! 'api/v1/users/minimal.json.jbuilder', user: user
end
