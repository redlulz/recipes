class Studio < FPM::Cookery::Recipe
  description   'The Official IDE for Android'

  name          'android-studio'
  version       '3.0.0.18'
  buildid =     '171.4408382'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/studio/index.html'
  source        "https://dl.google.com/dl/android/studio/ide-zips/#{version}/android-studio-ide-#{buildid}-linux.zip"
  sha256        '7991f95ea1b6c55645a3fc48f1534d4135501a07b9d92dd83672f936d9a9d7a2'

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
