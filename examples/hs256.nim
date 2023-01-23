import jwtea, std/json

let
  header = %*{
    "alg": "HS256",
    "typ": "JWT"
  }
  claims = %*{
    "sub": "1234567890",
    "name": "John Doe",
    "iat": 1516239022
  }
  secret = "abcdefghijklmnopqrstuvwxyz0123456789"
  jwt = signJwt(header, claims, secret)

echo jwt
