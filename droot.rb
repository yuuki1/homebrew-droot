class Droot < Formula
  homepage 'https://github.com/yuuki1/droot'
  version '0.2.1'

  if Hardware.is_64_bit?
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.1/droot_darwin_amd64.zip'
    sha256 'f561f0c2a77f6bba6e7507faa308e9e38979a66b9756c386288db33dad2c2270'
  else
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.1/droot_darwin_386.zip'
    sha256 '35a204941d0b10a1f420c9d97c963c8651c0c26f60c3353c6f3bcb831471ca04'
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
