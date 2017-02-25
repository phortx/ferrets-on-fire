require 'ferrets_on_fire'
require 'ferrets_on_fire/dsl'

describe FerretsOnFire::DSL do
  subject { Class.new { extend FerretsOnFire::DSL } }

  it { is_expected.to be_a(FerretsOnFire::DSL::DeclarationDSL) }
  it { is_expected.to be_a(FerretsOnFire::DSL::ShellDSL) }
  it { is_expected.to be_a(FerretsOnFire::DSL::LoggerDSL) }
  it { is_expected.to be_a(FerretsOnFire::DSL::GitDSL) }

  describe '#root' do
    it 'returns the base path' do
      expect(subject.root).to eq(Bundler.root)
    end
  end


  describe '#load_lib' do
    it 'adds the lib dir to the load path' do
      lib_path = "#{Bundler.root}/lib"

      expect($:).to receive(:<<).with(lib_path)
      subject.load_lib
    end
  end
end
