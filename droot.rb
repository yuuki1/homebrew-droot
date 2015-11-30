class Droot < Formula
  homepage 'https://github.com/yuuki1/droot'
  version '0.0.1'

  if Hardware.is_64_bit?
    url 'https://github.com/yuuki1/droot/releases/download/v0.1.0/droot_darwin_amd64.zip'
    sha256 '2b7dbc0c5349e1e062661688ce8e4f23548ad2f501c9f6f1a16edfbbe9c507f3'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.3/rexdep_darwin_386.zip'
    sha256 'df433de715d69b3de1afdbd7122c056eab4cf99909a3935af87a432e82af8b38'
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
