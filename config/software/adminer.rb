name "adminer"
default_version "4.3.0"
skip_transitive_dependency_licensing true


build do
  command "mkdir -p #{install_dir}/var/lib/adminer-server/public"
  command "curl -L https://github.com/vrana/adminer/releases/download/v#{version}/adminer-#{version}.php -o #{install_dir}/var/lib/adminer-server/public/adminer.php" 
end
