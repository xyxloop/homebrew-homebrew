class Zvbi < Formula
  desc "VBI capture and decoding library"
  homepage "http://zapping.sourceforge.net/ZVBI/"
  url "https://salsa.debian.org/debian/zvbi/-/archive/6aa67af160a6f727fb583d890f4a5a5ae8471d3e/zvbi-6aa67af160a6f727fb583d890f4a5a5ae8471d3e.tar.gz"
  sha256 "4531d8203822ecd24155415ad7e7102cee7a37dc70734d0fdee2a51b99b27853"

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
    ]

    system "./configure", *args
    system "make", "install"
  end
  
  test do
    assert_match "Usage:", shell_output("#{bin}/strings #{bin}/strings")
  end
end
