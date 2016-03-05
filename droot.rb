class Droot < Formula
  droot_version = '0.4.0'
  homepage 'https://github.com/yuuki1/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '5ea0ef1c5659741723f92abe8f62402dfe2399c00daf44cf6d308c1b3d660c30'
  else
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 '72a6ec18d1b8e7acf23371c30793745d12638efd10b025ea604b064668cfa10a'
  end

  head do
    url 'https://github.com/yuuki1/droot.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/yuuki1'
      ln_s buildpath, buildpath/'.go/src/github.com/yuuki1/droot'
      system 'make', 'build'
    end
    bin.install 'droot'
  end

  test do
    system 'droot', '--version'
  end
end
