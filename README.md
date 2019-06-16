[![Build Status](https://travis-ci.org/AlexAvlonitis/rails-5-api.svg?branch=master)](https://travis-ci.org/AlexAvlonitis/rails-5-api)

# RAILS 5 API TEMPLATE
## With JWT Authentication

# How to use

## Download
* git clone git@github.com:AlexAvlonitis/rails-5-api.git && cd rails-5-api

## Setup
* bundle install
* copy .env.example file to .env and add required values
* rake db:setup

## Examples using curl
### Creating a new user

**Request**
```json
curl -H "Content-Type: application/json" \
     -X POST -d '{"email":"myname@myemail.com","password":"12345678"}' \
     http://localhost:3000/api/user/sign_up
```
**Response**
Sign up success message and a JWT token
```json
{
  "message":"User created successfully",
  "access_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4LCJleHAiOjE1MTQyMjYxMDN9.ADOGnYeexJpJj8SCHZHL_JFJ3iza9MmXTyWb8wGSFws"
}
```

### Logging in
**Request**
```json
curl -H "Content-Type: application/json" \
     -X POST -d '{"email":"myname@myemail.com","password":"12345678"}' \
     http://localhost:3000/api/user/sign_in
```
**Response** Login success message and a JWT token
```json
{
  "access_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4LCJleHAiOjE1MTQyMjY0MjB9.u-6sECl-_GVj5JfE90ExGcGC5QR8xuJDh_FDbAFI7-w",
  "message":"Login Successful"
}
```

### Accessing a protected endpoint
**Resquest** Replace the Authorization token with a valid one, after sign_in or sign_up
```json
curl -H "Content-Type: application/json" \
     -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4LCJleHAiOjE1MTQyMjcxMjF9.HRXFrrWU9ZRBCaYflOIAPskEcpNVcZQ7neGOwGTBqeM" \
     -X GET http://localhost:3000/api/users
```
**Response**
```json
[
  {"email":"asd@asd.com"},
  {"email":"qwe@qwe.com"},
  {"email":"myname@myemail.com"}
]
```

## Rake Tasks

**Rename/Personalize the application**
```ruby
rake rename[NewName]
```

## Testing
```ruby
bundle exec rspec
```

## To Do list
- [x] Add user sign up
- [x] Add user sign in
- [x] Add JWT authentication
- [ ] Add password reset feature
- [ ] Add password_confirmation field on Sign up
- [ ] Add email token-confirmation after Sign up
- [ ] Add Rack Attack gem, and configure it
