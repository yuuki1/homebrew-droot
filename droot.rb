class Droot < Formula
  homepage 'https://github.com/yuuki1/droot'
  version '0.2.0'

  if Hardware.is_64_bit?
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.0/droot_darwin_amd64.zip'
    sha256 'f6f8e5f977b476b311a5944b044f469ad78206efe50fcd7dd5ab9b3f87c2c262'
  else
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.0/droot_darwin_386.zip'
    sha256 'b20620178c0a7c292ff1a6b11f400d024acf21119b9c3670373027c64901ceff'
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
