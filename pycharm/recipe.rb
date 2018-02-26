class PyCharm < FPM::Cookery::Recipe
  description   'Python IDE for Professional Developers'

  name          'pycharm-professional'
  version       '2017.3.3'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/pycharm/'
  source        "https://download.jetbrains.com/python/#{name}-#{version}.tar.gz"
  sha256        'f97d56f15750b6a1a94aeeeaab16ab7b6b52f3a32a01f28e2439aa44d4e60ca0'

  depends       'default-jre', 'python3'

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
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

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
