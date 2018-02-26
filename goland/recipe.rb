class GoLand < FPM::Cookery::Recipe
  description   'Go IDE'

  name          'goland'
  version       "2017.3.2"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/go/'
  source        "https://download.jetbrains.com/go/goland-#{version}.tar.gz"
  sha256        '75bf38b71542976c5c5865847cff08298ec21584d9162db047c55f8a7b901b2e'

  depends       'default-jre', 'golang'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/goland.vmoptions
    /opt/#{name}/bin/goland64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

    share('applications').install workdir('goland.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/goland.png')
    executablelink = bin('goland')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/goland.png")
      executablelink.make_symlink opt("#{name}/bin/goland.sh")
    end
  end
end
