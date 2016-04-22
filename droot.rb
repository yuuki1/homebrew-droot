class Droot < Formula
  droot_version = '0.6.0'
  homepage 'https://github.com/yuuki/droot'
  version droot_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_amd64.zip"
    sha256 '02d579167e2ca2d804d6cc8a1ec29aaa8c65624abb2decee3a9bb52d5b9da7c2'
  else
    url "https://github.com/yuuki/droot/releases/download/v#{droot_version}/droot_darwin_386.zip"
    sha256 'd1d289b73d7f5f7f948eba6f937efa54a37ef494782a36eddb88e77f4d9ca452'
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
