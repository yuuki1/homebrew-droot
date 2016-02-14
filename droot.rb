class Droot < Formula
  droot_version = '0.3.0'
  homepage 'https://github.com/yuuki1/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '8b572f8dff888ab7a2da00a5ff96bce5a64da2c5e0d0e8f33a13e058783ba93a'
  else
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 '8a96170fb9dc3604d6d805df87aca75c49fabd0d00929c24e3dd730d6cb2bf24'
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
