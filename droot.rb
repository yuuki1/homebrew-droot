class Droot < Formula
  droot_version = '0.7.6'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  # support only amd64
  url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
  sha256 'd9272381eae14b3b113dcbea77918be3e978fcbf4a7cf28b4642edbba5d46244'

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
