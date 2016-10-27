class CLion < FPM::Cookery::Recipe
  description   'A cross-platform IDE for C and C++'

  name          'clion'
  version       '2016.2.3'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/clion/'
  source        "https://download.jetbrains.com/cpp/CLion-#{version}.tar.gz"
  sha256        '0d2fc6ecec4dfab15ba98021ed3d3e866c2d43e7c27b7e522e0161e76aa78fbd'

  depends       'default-jre'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/clion64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre").rmtree

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
