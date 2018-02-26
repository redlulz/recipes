class Idea < FPM::Cookery::Recipe
  description   'The most intelligent Java IDE'

  name          'intellij-idea-ultimate'
  version       '2017.3.4'
  revision      1
  section       'devel'
  vendor        'JetBrains'
  homepage      'https://www.jetbrains.com/idea/'
  source        "https://download.jetbrains.com/idea/ideaIU-#{version}.tar.gz"
  sha256        'd1f33796fa317c04e0618a9bd329f944355c3374011815c398384ca5cc57bfbc'

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
