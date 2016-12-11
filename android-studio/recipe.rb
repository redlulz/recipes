class Studio < FPM::Cookery::Recipe
  description   'The Official IDE for Android'

  name          'android-studio'
  version       '2.2.3.0'
  buildid =     '145.3537739'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/studio/index.html'
  source        "https://dl.google.com/dl/android/studio/ide-zips/#{version}/android-studio-ide-#{buildid}-linux.zip"
  sha1          '172c9b01669f2fe46edcc16e466917fac04c9a7f'

  depends       'default-jdk'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/studio.vmoptions
    /opt/#{name}/bin/studio.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre").rmtree

    share('applications').install workdir('android-studio.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/android-studio.png')
    executablelink = bin('android-studio')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/studio.png")
      executablelink.make_symlink opt("#{name}/bin/studio.sh")
    end
  end
end
