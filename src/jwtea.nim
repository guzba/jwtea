import crunchy/rsa, crunchy/sha256, std/base64, std/json

proc base64UrlEncodeWithoutPadding(s: string): string =
  result = encode(s, safe = true)
  while result[result.high] == '=':
    result.setLen(result.len - 1)

proc signJwt*(header, claims: JsonNode, secret: string): string =
  let
    header64 = base64UrlEncodeWithoutPadding($header)
    claims64 = base64UrlEncodeWithoutPadding($claims)

  result = header64 & '.' & claims64

  var signature: string

  let alg = header.getOrDefault("alg").getStr()
  if alg == "RS256":
    let privateKey = decodePrivateKey(secret)
    signature = base64UrlEncodeWithoutPadding(privateKey.sign(result))
  elif alg == "HS256":
    let hmac = hmacSha256(secret, result)
    var tmp = newString(32)
    for i in 0 ..< 32:
      tmp[i] = hmac[i].char
    signature = base64UrlEncodeWithoutPadding(tmp)
  else:
    raise newException(CatchableError, "Unsupported JWT alg: " & alg)

  result &= '.' & signature
