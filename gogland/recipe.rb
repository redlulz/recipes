class Gogland < FPM::Cookery::Recipe
  description   'Go IDE'

  name          'gogland'
  buildid =     '171.4694.35'
  version       "2017.1-EAP-9-#{buildid}"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/go/'
  source        "https://download.jetbrains.com/go/gogland-#{buildid}.tar.gz"
  sha256        '539a19bb452835093c5692a1312c942500f161d444207b5907329128e2424e60'

  depends       'default-jre', 'golang'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/gogland.vmoptions
    /opt/#{name}/bin/gogland64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

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
