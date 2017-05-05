class AndroidNDK < FPM::Cookery::Recipe
  description   'The Android NDK is a toolset that lets you implement parts of your app using native-code languages such as C and C++.'

  name          'android-ndk'
  version       '14b'
  revision      1
  section       'devel'
  vendor        'Google'
  homepage      'https://developer.android.com/ndk/index.html'
  source        "https://dl.google.com/android/repository/android-ndk-r#{version}-linux-x86_64.zip"
  sha1          'becd161da6ed9a823e25be5c02955d9cbca1dbeb'

  def build
  end

  def install
    opt("#{name}").install Dir['*']
  end
end
