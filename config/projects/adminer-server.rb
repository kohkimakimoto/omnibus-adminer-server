name "adminer-server"
maintainer "Kohki Makimoto"
homepage "https://github.com/kohkimakimoto/omnibus-adminer-server"

# Defaults to C:/adminer-server on Windows
# and /opt/adminer-server on all other platforms
install_dir "#{default_root}/#{name}"

build_version "0.1.0"
build_iteration 1

# Creates required build directories
dependency "preparation"
dependency "apache"
dependency "php"
dependency "adminer"
dependency "adminer-server"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
