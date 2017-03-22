name "adminer-server"
default_version "master"
skip_transitive_dependency_licensing true

build do
  path_override_env = with_standard_compiler_flags(with_embedded_path).merge(
    "PATH" => "#{install_dir}/embedded/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin",
  )

  block do
    root_path = "/" # for ERBadi
    install_path = project.install_dir # for ERB
    project_name = project.name # for ERB
    project_name_snake = project.name.gsub('-', '_') # for variable names in ERB

    template = ->(*parts) { File.join('templates', *parts) }
    generate_from_template = ->(dst, src, erb_binding, opts={}) {
      mode = opts.fetch(:mode, 0755)
      FileUtils.mkdir_p File.dirname(dst)
      File.open(dst, 'w', mode) do |f|
        f.write ERB.new(File.read(src)).result(erb_binding)
      end
    }

    # init.d file
    # templates/etc/init.d/xxx/adminer-server -> ./opt/adminer-server/etc/init.d/adminer-server
    file_path = File.join(install_path, 'etc', 'init.d', 'adminer-server')
    generate_from_template.call file_path, template.call('etc', 'init.d', 'adminer-server'), binding, mode: 0755

    # logrotate.d
    # templates/etc/logrotate.d/adminer-server -> ./opt/adminer-server/etc/logrotate.d/adminer-server
    file_path = File.join(install_path, 'etc', 'logrotate.d', 'adminer-server')
    generate_from_template.call file_path, template.call('etc', 'logrotate.d', 'adminer-server'), binding, mode: 0644

    # httpd.conf
    # templates/etc/adminer-server/httpd.conf -> ./opt/adminer-server/etc/adminer-server/httpd.conf
    file_path = File.join(install_path, 'etc', 'adminer-server', 'httpd.conf')
    generate_from_template.call file_path, template.call('etc', 'adminer-server', 'httpd.conf'), binding, mode: 0644

    # adminer-server.service
    # templates/usr/lib/systemd/system/adminer-server.service -> ./opt/adminer-server/usr/lib/systemd/system/adminer-server.service
    file_path = File.join(install_path, 'usr', 'lib', 'systemd', 'system', 'adminer-server.service')
    generate_from_template.call file_path, template.call('usr', 'lib', 'systemd', 'system', 'adminer-server.service'), binding, mode: 0644

    # php.ini
    # templates/etc/adminer-server/php.ini -> ./opt/adminer-server/etc/adminer-server/php.ini
    file_path = File.join(install_path, 'etc', 'adminer-server', 'php.ini')
    generate_from_template.call file_path, template.call('etc', 'adminer-server', 'php.ini'), binding, mode: 0644

    file_path = File.join(install_path, 'var', 'lib', 'adminer-server', 'public', 'adminer.css')
    generate_from_template.call file_path, template.call('var', 'lib', 'adminer-server', 'public', 'adminer.css'), binding, mode: 0644

    file_path = File.join(install_path, 'var', 'lib', 'adminer-server', 'public', 'index.php')
    generate_from_template.call file_path, template.call('var', 'lib', 'adminer-server', 'public', 'index.php'), binding, mode: 0644
  end
end

