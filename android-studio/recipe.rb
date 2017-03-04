class Studio < FPM::Cookery::Recipe
  description   'The Official IDE for Android'

  name          'android-studio'
  version       '2.3.0.8'
  buildid =     '162.3764568'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/studio/index.html'
  source        "https://dl.google.com/dl/android/studio/ide-zips/#{version}/android-studio-ide-#{buildid}-linux.zip"
  sha256        '214cee47ef7a628c712ae618f5aab6c2a56a72aa479a50937d4cad5a0abf8435'

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
