class Droot < Formula
  droot_version = '0.7.3'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  # support only amd64
  url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
  sha256 '134967376bac232e81c7d2831623fe7a2b96aaabe1a5598b83f993e1dd0a10de'

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
