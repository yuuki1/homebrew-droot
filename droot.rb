class Droot < Formula
  droot_version = '0.7.7'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  # support only amd64
  url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
  sha256 'ec9efb6249e0e4797bde75afbfe962e0db81c530b5bb1cfd2cbe0e2fc2c8cf48'

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
