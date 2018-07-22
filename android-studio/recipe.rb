class Studio < FPM::Cookery::Recipe
  description   'The Official IDE for Android'

  name          'android-studio'
  version       '3.1.2'
  buildid =     '173.4720617'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/studio/index.html'
  source        "https://dl.google.com/dl/android/studio/ide-zips/#{version}/android-studio-ide-#{buildid}-linux.zip"
  sha256        '13f290279790df570bb6592f72a979a495f7591960a378abea7876ece7252ec1'

  depends       'default-jdk'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/studio.vmoptions
    /opt/#{name}/bin/studio64.vmoptions
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
