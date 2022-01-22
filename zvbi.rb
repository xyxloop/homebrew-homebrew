class Zvbi < Formula
  desc "VBI capture and decoding library"
  homepage "http://zapping.sourceforge.net/ZVBI/"
  url "https://salsa.debian.org/debian/zvbi/-/archive/debian/master/zvbi-debian-master.tar.gz"
  sha256 "4531d8203822ecd24155415ad7e7102cee7a37dc70734d0fdee2a51b99b27853"
  
  head do
    url "https://salsa.debian.org/debian/zvbi.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  
  def install
    cp Dir["#{Formula["libtool"].opt_share}/libtool/*/config.{guess,sub}"], buildpath
    system "./autogen.sh" if build.head?
    
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/zvbi-ntsc-cc", "-h"
  end
end
