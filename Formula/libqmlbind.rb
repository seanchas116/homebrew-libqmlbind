class Libqmlbind < Formula
  desc "A C library for creating QML bindings for other languages"
  homepage "https://github.com/seanchas116/libqmlbind"
  url "https://github.com/seanchas116/libqmlbind/archive/v0.2.0.tar.gz"
  sha256 "0bcba6c6189770ca269394ca346c2fe33739f236378439b9f3d5d144341ed6a3"
  head "https://github.com/seanchas116/libqmlbind.git"
  keg_only "libqmlbind depends on Qt 5 which is keg only"
  depends_on "qt5"

  def install
    cd "qmlbind" do
      system "qmake INSTALL_PREFIX=#{prefix}"
      system "make"
      system "make install"
    end
  end

  test do
    (testpath/"main.c").write <<-EOS
      #include <qmlbind.h>
      int main(int argc, char *argv[]) {
        qmlbind_application *app = qmlbind_application_new(argc, (const char* const *)argv);
        qmlbind_application_release(app);
      }
    EOS
    system "clang main.c -L/usr/local/opt/libqmlbind/lib -I/usr/local/opt/libqmlbind/include -lqmlbind"
  end
end
