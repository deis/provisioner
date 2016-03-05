# This file shows the format of the "questions" file - the file that coordinates
# how and in what order questions are asked of the user

text = "Rigger Configuration Questions"

[source]
type = "choice"
text = "What source should be used for the Deis deployment?"
default = "source.release_version"

  [source.release]
  text = "release version"
  next = "version"

  [source.git]
  text = "git tag"
  next = "git"

  [source.path]
  text = "path"
  next = "project_directory"

[project_directory]
type = "free"
text = "Where can I find the Deis project on your system?"
next = "build"

[git]
type = "action"
action = "setup-git"
text = "So you'll be using Git... let me configure that right quick!"

  [git.url]
  type = "free"
  text = "What git repository should I use?"
  default = "https://github.com/deis/deis.git"
  next = "git.sha"

  [git.sha]
  type = "free"
  text = "What git branch/tag/sha1 should I checkout?"
  default = "master"
  next = "build"

[go]
type = "action"
action = "setup-go"
text = "You'll need Go... let me configure that in a jiffy."

  [go.path]
  type = "free"
  text = "What should I use for your GOPATH?"
  default = "GOPATH"
  next = "build"

[build]
type = "choice"
text = "Would you like to build the whole platform or just the clients?"
default = "build.whole_platform"

  [build.whole_platform]
  text = "whole platform"
  next = "provider"

  [build.clients_only]
  text = "clients only"
  next = "version"

[version]
type = "free"
text = "What release version of Deis should I deploy?"
default = "latest release"

[provider]
type = "choice"
text = "What provider would you like to deploy Deis onto?"
default = "provider.vagrant"

  [provider.vagrant]
  text = "vagrant"
  next = "vagrant"

  [provider.aws]
  text = "aws"
  next = "aws"

  [provider.digitalocean]
  text = "digitalocean"
  next = "digitalocean"

[vagrant]
type = action
action = setup-vagrant
text = "So you'll be deploying on Vagrant... let me configure that provider!"
next = [complete]

[aws]
type = action
action = setup-aws
text = "So you'll be deploying on AWS... let me configure that provider!"
next = [aws.key]

  [aws.key]
  type = "free"
  text = "Enter the AWS key:"
  next = [aws.secret_key]

  [aws.secret_key]
  type = "free"
  text = "Enter the AWS secret key:"
  next = [complete]

[digitalocean]
type = action
action = setup-digitalocean
text = "So you'll be deploying on Digital Ocean... let me configure that provider!"
next = "digitalocean.token"

  [digitalocean.token]
  type = "free"
  text = "Enter Digital Ocean token:"
  next = "digitalocean.fingerprint"

  [digitalocean.fingerprint]
  type = "free"
  text = "Enter Digital Ocean SSH fingerprint:"
  next = "complete"

[complete]
type = action
action = print-summary
text = "Configuration is now complete!"
next = "exit"
