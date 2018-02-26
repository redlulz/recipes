class Rider < FPM::Cookery::Recipe
  description   'A cross-platform .NET IDE based on the IntelliJ platform and ReSharper'

  name          'rider'
  version       '2017.3.1'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/rider/'
  source        "https://download.jetbrains.com/resharper/JetBrains.Rider-#{version}.tar.gz"
  sha256        '7bc6b7700b55396fd10a46af83e14ef3336a71f7326947fd3502cd4a01603e4d'

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
