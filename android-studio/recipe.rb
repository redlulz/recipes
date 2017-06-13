class Studio < FPM::Cookery::Recipe
  description   'The Official IDE for Android'

  name          'android-studio'
  version       '2.3.3.0'
  buildid =     '162.4069837'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/studio/index.html'
  source        "https://dl.google.com/dl/android/studio/ide-zips/#{version}/android-studio-ide-#{buildid}-linux.zip"
  sha256        '1383cfd47441e5f820b6257a1bdd683e0e980bc76c7f2027ef84dc2e6ad2f17f'

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
