class Rider < FPM::Cookery::Recipe
  description   'A cross-platform .NET IDE based on the IntelliJ platform and ReSharper'

  name          'rider'
  buildid =     '171.4456.575'
  version       "2017.1-EAP-23-#{buildid}"
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/rider/'
  source        "https://download.jetbrains.com/resharper/riderRS-#{buildid}.tar.gz"

  depends       'default-jre', 'mono-devel'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/rider.vmoptions
    /opt/#{name}/bin/rider64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

    share('applications').install workdir('rider.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/rider.png')
    executablelink = bin('rider')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/rider.png")
      executablelink.make_symlink opt("#{name}/bin/rider.sh")
    end
  end
end
