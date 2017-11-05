class GoLand < FPM::Cookery::Recipe
  description   'Go IDE'

  name          'goland'
  buildid =     '173.3531.21'
  version       "2017.3-EAP-18-#{buildid}"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/go/'
  source        "https://download.jetbrains.com/go/goland-#{buildid}.tar.gz"
  sha256        '5738129cb5ab81428cf6fa0ec18e97221b1303d966e679e575a0ac8e669170cd'

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
