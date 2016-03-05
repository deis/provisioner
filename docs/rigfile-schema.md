# This file is a representation of the Rigfile format

[source]

  [source.release]
  version = "..."

  OR

  [source.path]
  dir = "..."

  OR

  [source.git]
  url = "..."
  sha1 = "..."

[build]
components = "all" | "clients-only"

[platform]
version = "..."

[provider]
type = "vagrant" | "aws" | "digitalocean"

  [vagrant]

  OR

  [aws]
  key = "..."
  secret_key = "..."

  OR

  [digitalocean]
  token = "..."
  fingerprint = "..."
