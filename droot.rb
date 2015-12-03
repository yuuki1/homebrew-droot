class Droot < Formula
  homepage 'https://github.com/yuuki1/droot'
  version '0.2.0'

  if Hardware.is_64_bit?
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.0/droot_darwin_amd64.zip'
    sha256 '9fede02c6c4e7246c72fbc2979d64cbeee1d18ecfe4d3826a3e9856c33de4e49'
  else
    url 'https://github.com/yuuki1/droot/releases/download/v0.2.0/droot_darwin_386.zip'
    sha256 '66fc9b89197b89e1de8af843fcf67bbcb142fd16a75eb582ad34a200c9835168'
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
