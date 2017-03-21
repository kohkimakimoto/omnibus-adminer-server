name "apr"
default_version "1.5.2"
skip_transitive_dependency_licensing true

version "1.5.2" do
  source md5: "98492e965963f852ab29f9e61b2ad700"
end

source url: "http://ftp.riken.jp/net/apache//apr/apr-#{version}.tar.gz"

relative_path "apr-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
