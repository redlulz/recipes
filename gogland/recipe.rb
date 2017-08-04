class Gogland < FPM::Cookery::Recipe
  description   'Go IDE'

  name          'gogland'
  buildid =     '172.3757.2'
  version       "2017.2-EAP-11-#{buildid}"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/go/'
  source        "https://download.jetbrains.com/go/gogland-#{buildid}.tar.gz"
  sha256        'f462771c6a21b94a0cf460d0506e93860bc59223108defcbbbfc8a9bf824e89f'

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
