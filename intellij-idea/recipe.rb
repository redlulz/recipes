class Idea < FPM::Cookery::Recipe
  description   'The most intelligent Java IDE'

  name          'intellij-idea-ultimate'
  version       '2017.1.5'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/idea/'
  source        "https://download.jetbrains.com/idea/ideaIU-#{version}.tar.gz"
  sha256        'a38c24a43aee6cbba1643975e587c1a4e6ef7b49c30388229cb3628621702dfc'

  depends       'default-jdk'

  provides      'intellij-idea'
  replaces      'intellij-idea'
  conflicts     'intellij-idea'

  config_files  %W(
    /opt/#{name}/bin/idea.properties
    /opt/#{name}/bin/idea.vmoptions
    /opt/#{name}/bin/idea64.vmoptions
  )

  def build
  end

  def install
    opt("#{name}").install Dir['*']
    opt("#{name}/jre64").rmtree

    share('applications').install workdir('intellij-idea-ultimate.desktop')

    share('pixmaps').mkpath
    bin.mkpath
    iconlink = share('pixmaps/intellij-idea.png')
    executablelink = bin('idea')
    with_trueprefix do
      iconlink.make_symlink opt("#{name}/bin/idea.png")
      executablelink.make_symlink opt("#{name}/bin/idea.sh")
    end
  end
end
