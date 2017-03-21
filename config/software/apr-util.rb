name "apr-util"
default_version "1.5.4"
skip_transitive_dependency_licensing true

version "1.5.4" do
  source md5: "866825c04da827c6e5f53daff5569f42"
end

source url: "http://ftp.riken.jp/net/apache//apr/apr-util-#{version}.tar.gz"

relative_path "apr-util-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --with-sqlite3=no" \
          " --with-apr=#{install_dir}/embedded" , env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
