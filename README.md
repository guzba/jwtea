# JWTea

`nimble install jwtea`

![Github Actions](https://github.com/guzba/jwtea/workflows/Github%20Actions/badge.svg)

[API reference](https://guzba.github.io/jwtea/)

JWTea enables the creation of JSON Web Tokens in pure Nim, without any dependency on OpenSSL or other external libraries.

OpenSSL is one of the truly legendary sources of programmer pain so this repo was motivated by refusing that dependency.

JWTea does not currently support all JWT algorithms. Two very popular algorithms, including RS256 used by Google, are supported now and support for more can be added.

Algorithm | Status
--- | ---:
HS256 | ✅
HS384 | ⛔
HS512 | ⛔
RS256 | ✅
RS384 | ⛔
RS512 | ⛔
ES256 | ⛔
ES384 | ⛔
ES512 | ⛔
PS256 | ⛔
PS384 | ⛔
PS512 | ⛔

To learn more about JWT, this site is a great reference: https://jwt.io

## How to use JWTea

Per the [JWT spec](https://www.rfc-editor.org/rfc/rfc7519), a JWT is created with 3 parts:

1) A header JSON object.
2) A claims JSON object.
3) A secret or private key.

JWTea avoids making it any more complicated than that:

`proc signJwt*(header, claims: JsonNode, secret: string): string`

## Examples

```nim
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
```

If you have an RSA private key, simply pass it to `signJwt` as the secret:

```nim
import jwtea, std/json

let
  header = %*{
    "alg": "RS256",
    "typ": "JWT"
  }
  claims = %*{
    "sub": "1234567890",
    "name": "John Doe",
    "admin": true,
    "iat": 1516239022
  }
  privateKey = """-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC7VJTUt9Us8cKj
MzEfYyjiWA4R4/M2bS1GB4t7NXp98C3SC6dVMvDuictGeurT8jNbvJZHtCSuYEvu
NMoSfm76oqFvAp8Gy0iz5sxjZmSnXyCdPEovGhLa0VzMaQ8s+CLOyS56YyCFGeJZ
qgtzJ6GR3eqoYSW9b9UMvkBpZODSctWSNGj3P7jRFDO5VoTwCQAWbFnOjDfH5Ulg
p2PKSQnSJP3AJLQNFNe7br1XbrhV//eO+t51mIpGSDCUv3E0DDFcWDTH9cXDTTlR
ZVEiR2BwpZOOkE/Z0/BVnhZYL71oZV34bKfWjQIt6V/isSMahdsAASACp4ZTGtwi
VuNd9tybAgMBAAECggEBAKTmjaS6tkK8BlPXClTQ2vpz/N6uxDeS35mXpqasqskV
laAidgg/sWqpjXDbXr93otIMLlWsM+X0CqMDgSXKejLS2jx4GDjI1ZTXg++0AMJ8
sJ74pWzVDOfmCEQ/7wXs3+cbnXhKriO8Z036q92Qc1+N87SI38nkGa0ABH9CN83H
mQqt4fB7UdHzuIRe/me2PGhIq5ZBzj6h3BpoPGzEP+x3l9YmK8t/1cN0pqI+dQwY
dgfGjackLu/2qH80MCF7IyQaseZUOJyKrCLtSD/Iixv/hzDEUPfOCjFDgTpzf3cw
ta8+oE4wHCo1iI1/4TlPkwmXx4qSXtmw4aQPz7IDQvECgYEA8KNThCO2gsC2I9PQ
DM/8Cw0O983WCDY+oi+7JPiNAJwv5DYBqEZB1QYdj06YD16XlC/HAZMsMku1na2T
N0driwenQQWzoev3g2S7gRDoS/FCJSI3jJ+kjgtaA7Qmzlgk1TxODN+G1H91HW7t
0l7VnL27IWyYo2qRRK3jzxqUiPUCgYEAx0oQs2reBQGMVZnApD1jeq7n4MvNLcPv
t8b/eU9iUv6Y4Mj0Suo/AU8lYZXm8ubbqAlwz2VSVunD2tOplHyMUrtCtObAfVDU
AhCndKaA9gApgfb3xw1IKbuQ1u4IF1FJl3VtumfQn//LiH1B3rXhcdyo3/vIttEk
48RakUKClU8CgYEAzV7W3COOlDDcQd935DdtKBFRAPRPAlspQUnzMi5eSHMD/ISL
DY5IiQHbIH83D4bvXq0X7qQoSBSNP7Dvv3HYuqMhf0DaegrlBuJllFVVq9qPVRnK
xt1Il2HgxOBvbhOT+9in1BzA+YJ99UzC85O0Qz06A+CmtHEy4aZ2kj5hHjECgYEA
mNS4+A8Fkss8Js1RieK2LniBxMgmYml3pfVLKGnzmng7H2+cwPLhPIzIuwytXywh
2bzbsYEfYx3EoEVgMEpPhoarQnYPukrJO4gwE2o5Te6T5mJSZGlQJQj9q4ZB2Dfz
et6INsK0oG8XVGXSpQvQh3RUYekCZQkBBFcpqWpbIEsCgYAnM3DQf3FJoSnXaMhr
VBIovic5l0xFkEHskAjFTevO86Fsz1C2aSeRKSqGFoOQ0tmJzBEs1R6KqnHInicD
TQrKhArgLXX4v3CddjfTRJkFWDbE/CkvKZNOrcf1nhaGCPspRJj2KUkj1Fhl9Cnc
dn/RsYEONbwQSjIfMPkvxF+8HQ==
-----END PRIVATE KEY-----"""

echo "JWT = ", signJwt(header, claims, privateKey)
```

## Testing

`nimble test`
