class Droot < Formula
  droot_version = '0.6.2'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  if Hardware::CPU.is_64_bit?
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 'ce15eb866d08f4d926ff9daddf4432e9bfaff722409e94228cea7dbdf700dced'
  else
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 '9d6792922477681225680b8f00e3f33504cb4f69f86f8b65146f83d566ab5871'
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
