class Droot < Formula
  droot_version = '0.2.3'
  homepage 'https://github.com/yuuki1/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '584e0d4c0df219d195c984c0a714c5b1b3b9dbfaa2ba1922565f1b8166730439'
  else
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'e951d3af4053037d55b86c7142471a50a5912596e6f673b89c671050b3a3fe28'
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
