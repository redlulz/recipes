class PyCharm < FPM::Cookery::Recipe
  description   'Python IDE for Professional Developers'

  name          'pycharm-professional'
  version       '2016.1.4'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/pycharm/'
  source        "https://download.jetbrains.com/python/#{name}-#{version}.tar.gz"
  sha256        '47323791c67105b2ce57a531d8965915186b9f19f4e234e65c4b3dca31c87333'

  depends       'default-jre', 'python | python3'

  provides      'pycharm'
  replaces      'pycharm'
  conflicts     'pycharm'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/pycharm.vmoptions
    /opt/#{name}/bin/pycharm64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['bin', 'debug-eggs', 'help', 'helpers', 'lib', 'license', 'plugins', 'build.txt']

    share('applications').install workdir('pycharm-professional.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/pycharm.png')
    executablelink = bin('pycharm')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/pycharm.png")
      executablelink.make_symlink opt("#{name}/bin/pycharm.sh")
    end
  end
end
