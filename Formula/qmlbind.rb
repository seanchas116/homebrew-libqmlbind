class Qmlbind < Formula
  desc "A C library for creating QML bindings for other languages"
  homepage "https://github.com/seanchas116/libqmlbind"
  url "https://github.com/seanchas116/libqmlbind/archive/v0.1.0.tar.gz"
  sha256 "9ddc32a5726de5fe30f4dc14c434ce558dd18fa2b6512605b279f23bf188e268"
  head "https://github.com/seanchas116/libqmlbind.git"
  keg_only "qmlbind depends on Qt 5 which is keg only"
  depends_on "qt5"

  def install
    cd "qmlbind" do
      system "qmake"
      system "make"
    end
    prefix.install "qmlbind/include"
    prefix.install Dir["qmlbind/lib*.dylib"]
  end
end
