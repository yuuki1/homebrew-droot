class Droot < Formula
  homepage 'https://github.com/yuuki1/droot'
  version '0.2.2'

  if Hardware.is_64_bit?
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.1/droot_darwin_amd64.zip'
    sha256 '4e1a72a859b25814bf9c85545616b9c74491b14c0696c3a3c781409fc2c8fe28'
  else
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.1/droot_darwin_386.zip'
    sha256 '46cfabd2dbb9f2f25bc2efd0ed78344695d59c366158d5901b8b5f400c8633e3'
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
