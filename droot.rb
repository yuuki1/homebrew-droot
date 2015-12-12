class Droot < Formula
  droot_version = '0.2.4'
  homepage 'https://github.com/yuuki1/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '11eddfacd038151d111582cdb513fe7aac56bfb8e1afa4377d44ee57000695c2'
  else
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'a75ddf554e5fea48fcf66b881d5187565e51e1b951b4539bfab35a94d6334f92'
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
