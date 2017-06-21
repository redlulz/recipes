class CLion < FPM::Cookery::Recipe
  description   'A cross-platform IDE for C and C++'

  name          'clion'
  version       '2017.1.3'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/clion/'
  source        "https://download.jetbrains.com/cpp/CLion-#{version}.tar.gz"
  sha256        'efb80d5c66db367b6d576923850c56dbb0054f44e0370a274ef37ae2d69ab710'

  depends       'default-jre'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/clion64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

    share('applications').install workdir('clion.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/clion.svg')
    executablelink = bin('clion')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/clion.svg")
      executablelink.make_symlink opt("#{name}/bin/clion.sh")
    end
  end
end
