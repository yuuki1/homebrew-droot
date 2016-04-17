class Droot < Formula
  droot_version = '0.5.0'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 'f28b7b4669ab517a0af8c41abb97815d2a6d0983f99ed9e5a938d99d69926120'
  else
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'e00bac061c13f651eb0bdf2197169ad968ad33c97d5a57639ed039cff50801e3'
  end

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
