class Gogland < FPM::Cookery::Recipe
  description   'Go IDE'

  name          'gogland'
  buildid =     '171.3780.106'
  version       "1.0-EAP-#{buildid}"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/go/'
  source        "https://download.jetbrains.com/go/gogland-#{buildid}.tar.gz"
  sha256        'cbe84d07fdec6425d8ac63b0ecd5e04148299c1c0c6d05751523aaaa9360110b'

  depends       'default-jre', 'golang'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/gogland.vmoptions
    /opt/#{name}/bin/gogland.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre").rmtree

    share('applications').install workdir('gogland.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/gogland.png')
    executablelink = bin('gogland')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/gogland.png")
      executablelink.make_symlink opt("#{name}/bin/gogland.sh")
    end
  end
end
