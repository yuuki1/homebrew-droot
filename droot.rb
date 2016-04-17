class Droot < Formula
  droot_version = '0.5.1'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '3fa185576093f21c534274a7ee3a8d26e3044af6d3f84803674a78c3d1680ee0'
  else
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 '9c66ba383571f56efb8a1791c50813b127be0a69cb545e79ad90b19306ff1ed4'
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
