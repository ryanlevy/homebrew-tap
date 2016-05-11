class Maxent < Formula
  desc "Utility for analytic continuation using the method of Maximum Entropy"
  homepage "https://github.com/CQMP/Maxent"
  url "https://github.com/CQMP/Maxent/archive/v1.0-rc3.tar.gz"
  version "1.0-rc3"
  sha256 "c00c161c69efe95e1b255da2b42c5a90da7caf75594702cd7a66c6e8c63d1193"
  head "https://github.com/CQMP/Maxent.git"

  option "with-test", "Build and run shipped tests"

  depends_on "cmake" => :build
  depends_on "alpscore"
  depends_on "eigen"
  depends_on "gsl"

  def install
    args = std_cmake_args
    mkdir "tmp" do
      args << ".."
      system "cmake", *args
      system "make", "-j4"
      system "make", "test" if build.with? "check"
      system "make", "install"
    end
  end

  test do
    (testpath/"testIn.param").write <<-EOS.undent
    BETA=2
    NDAT=10
    OMEGA_MAX=15
    PARTICLE_HOLE_SYMMETRY=false
    DATASPACE=frequency
    KERNEL=bosonic
    TEXT_OUTPUT=false
    N_ALPHA=2
    X_0=0.999999999999
    X_1=0
    X_2=0.70152821380558
    X_3=0.4474203984475
    X_4=0.38304188624212
    X_5=0.47620096397886
    X_6=0.22061301433115
    X_7=0.40641589593297
    X_8=0.13884046251264
    X_9=0.33897622833775
    SIGMA_0=1e-4
    SIGMA_1=1e-4
    SIGMA_2=1e-4
    SIGMA_3=1e-4
    SIGMA_4=1e-4
    SIGMA_5=1e-4
    SIGMA_6=1e-4
    SIGMA_7=1e-4
    SIGMA_8=1e-4
    SIGMA_9=1e-4
    EOS
    system "#{bin}/maxent", "testIn.param"
  end
end
