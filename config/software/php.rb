name "php"
default_version "7.0.12"
skip_transitive_dependency_licensing true

dependency "openssl"
dependency "zlib"
dependency "pcre"
dependency "libxslt"
dependency "libxml2"
dependency "libiconv"
dependency "krb5"
dependency "readline"
dependency "curl"
dependency "apache"
dependency "gd"
dependency "libXpm"

version "7.0.12" do
  source md5: "5dd00a65a1d76a4792f6989d4576623d"
end

source url: "http://us.php.net/distributions/php-#{version}.tar.gz"

relative_path "php-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --with-apxs2=#{install_dir}/embedded/bin/apxs" \
          " --with-config-file-path=/etc/adminer-server/" \
          " --with-config-file-scan-dir=/etc/adminer-server/php.conf.d" \
          " --without-pear" \
          " --disable-debug" \
          " --disable-phpdbg" \
          " --disable-cgi" \
          " --disable-fastcgi" \
          " --enable-sockets" \
          " --enable-exif" \
          " --enable-zip" \
          " --enable-soap" \
          " --enable-xmlreader" \
          " --enable-sysvsem" \
          " --enable-sysvshm" \
          " --enable-shmop" \
          " --enable-pcntl" \
          " --enable-mbstring" \
          " --enable-bcmath" \
          " --enable-sockets" \
          " --with-xmlrpc" \
          " --with-kerberos=#{install_dir}/embedded" \
          " --with-mysqli=mysqlnd" \
          " --with-pdo-mysql=mysqlnd" \
          " --with-pdo-sqlite" \
          " --with-gd=#{install_dir}/embedded" \
          " --with-xpm-dir=#{install_dir}/embedded" \
          " --with-readline=#{install_dir}/embedded" \
          " --with-curl=#{install_dir}/embedded" \
          " --with-zlib=#{install_dir}/embedded" \
          " --with-zlib-dir=#{install_dir}/embedded" \
          " --with-pcre-dir=#{install_dir}/embedded" \
          " --with-xsl=#{install_dir}/embedded" \
          " --with-libxml-dir=#{install_dir}/embedded" \
          " --with-iconv=#{install_dir}/embedded" \
          " --with-openssl=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
