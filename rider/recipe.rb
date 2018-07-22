class Rider < FPM::Cookery::Recipe
  description   'A cross-platform .NET IDE based on the IntelliJ platform and ReSharper'

  name          'rider'
  version       '2018.1.2'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/rider/'
  source        "https://download.jetbrains.com/rider/JetBrains.Rider-#{version}.tar.gz"
  sha256        '8c154d731807014b956c2758e1551e0f902abe9a3a75fee488cc9d5dc90352cb'

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
