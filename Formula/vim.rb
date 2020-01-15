class Vim < Formula
  desc "Vi 'workalike' with many additional features"
  homepage "https://www.vim.org/"
  url "https://github.com/vim/vim/archive/v8.2.0100.tar.gz"
  sha256 "13cc4d12fd6ebabc5f05a456f8f9451ae591a3473b87fda1d3a4f530123ae3d7"
  head "https://github.com/vim/vim.git"

  depends_on "python"

  env :std

  def install
    ENV.prepend_path "PATH", Formula["python"].opt_libexec/"bin"

    # https://github.com/Homebrew/homebrew-core/pull/1046
    ENV.delete("SDKROOT")

    # vim doesn't require any Python package, unset PYTHONPATH.
    ENV.delete("PYTHONPATH")

    # We specify HOMEBREW_PREFIX as the prefix to make vim look in the
    # the right place (HOMEBREW_PREFIX/share/vim/{vimrc,vimfiles}) for
    # system vimscript files. We specify the normal installation prefix
    # when calling "make install".
    system "./configure", "--prefix=#{HOMEBREW_PREFIX}",
                          "--mandir=#{man}",
                          "--with-features=normal",
                          "--enable-multibyte",
                          "--with-tlib=ncurses",
                          "--enable-cscope",
                          "--enable-terminal",
                          "--enable-python3interp",
                          "--with-python3-command=/usr/local/bin/python3",
                          "--disable-nls",
                          "--enable-gui=no",
                          "--without-x",
                          "--enable-fail-if-missing"
    system "make"

    # Parallel install could miss some symlinks
    # https://github.com/vim/vim/issues/1031
    ENV.deparallelize

    system "make", "install", "prefix=#{prefix}"
    bin.install_symlink "vim" => "vi"
  end
end
