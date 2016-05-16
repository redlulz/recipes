class CLion < FPM::Cookery::Recipe
  description   'A cross-platform IDE for C and C++'

  name          'clion'
  version       '2016.1.2'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/clion/'
  source        "https://download.jetbrains.com/cpp/CLion-#{version}.tar.gz"
  sha256        '3c840d557595e0f29f9f9229be005be2c022799537fd3af9a0949bc5c564473c'

  depends       'default-jre'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/clion64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['bin', 'help', 'lib', 'license', 'plugins', 'build.txt', 'Install-Linux-tar.txt']

    share('applications').install workdir('clion.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/clion.svg')
    executablelink = bin('clion')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/clion.svg")
      executablelink.make_symlink opt("#{name}/bin/clion.sh")
    end
  end
end
