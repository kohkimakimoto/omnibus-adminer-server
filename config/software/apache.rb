name "apache"
default_version "2.4.25"
skip_transitive_dependency_licensing true

dependency "pcre"
dependency "apr"
dependency "apr-util"
dependency "expat"
dependency "openssl"

version "2.4.25" do
  source md5: "24fb8b9e36cf131d78caae864fea0f6a"
end

source url: "http://ftp.riken.jp/net/apache//httpd/httpd-#{version}.tar.gz"

relative_path "httpd-#{version}"

build do
  # http://qiita.com/DQNEO/items/3613cc1d87c01121a9e2
  env = with_standard_compiler_flags(with_embedded_path).merge(
    "LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib"
  )

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --enable-layout=GNU" \
          " --with-apr=#{install_dir}/embedded" \
          " --with-apr-util=#{install_dir}/embedded" \
          " --enable-rewrite" \
          " --enable-ssl" \
          " --with-ssl=#{install_dir}/embedded" \
          " --with-mpm=prefork", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
