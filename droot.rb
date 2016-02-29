class Droot < Formula
  droot_version = '0.3.1'
  homepage 'https://github.com/yuuki1/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 'ebad2b191c70d8a8af1776bfca0f4d3bc52573a7546423ba2c454c025befdea2'
  else
    url "https://github.com/yuuki1/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'e19b75df7d4038d60b2afab35d1ce54df95c41d0cb4c7094826eca051aaf2744'
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
