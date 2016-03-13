class Droot < Formula
  droot_version = '0.4.1'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '5d149197bc70b8ff0382b0aa56df4e15cb6b0a9b33b6716d8a3aaaa9795fcc5d'
  else
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'ff55a9f750b41ee80d76f0e0de0e5a8f89e3cd339789bf487abfe3d318dbd0f4'
  end

  head do
    url 'https://github.com/yuuki/droot.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/yuuki'
      ln_s buildpath, buildpath/'.go/src/github.com/yuuki/droot'
      system 'make', 'build'
    end
    bin.install 'droot'
  end

  test do
    system 'droot', '--version'
  end
end
