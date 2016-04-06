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
    (prefix/"lib").install Dir["qmlbind/lib*.dylib"]
  end

  test do
    (testpath/"main.c").write <<-EOS
      #include <qmlbind.h>
      int main(int argc, char *argv[]) {
        qmlbind_application *app = qmlbind_application_new(argc, (const char* const *)argv);
        qmlbind_application_release(app);
      }
    EOS
    system "clang main.c -L/usr/local/opt/qmlbind/lib -I/usr/local/opt/qmlbind/include -lqmlbind"
  end
end
