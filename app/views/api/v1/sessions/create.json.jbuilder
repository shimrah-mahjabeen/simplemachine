json.status 200
json.user do
  json.partial! 'api/v1/users/minimal.json.jbuilder', user: @resource

  json.must_change_password @resource.must_change_password
end
