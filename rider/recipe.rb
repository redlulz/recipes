class Rider < FPM::Cookery::Recipe
  description   'A cross-platform .NET IDE based on the IntelliJ platform and ReSharper'

  name          'rider'
  version       '2017.1.1'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/rider/'
  source        "https://download.jetbrains.com/resharper/JetBrains.Rider-#{version}.tar.gz"
  sha256        '65a462b1de4eb4d99489c3e4d8a36b9bd359f0782e1e2146cbaab51f0f41d7c0'

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
